-- youtube-quality.lua
--
-- Change youtube video quality on the fly.
--
-- Diplays a menu that lets you switch to different ytdl-format settings while
-- you're in the middle of a video (just like you were using the web player).
--
-- Bound to ctrl-f by default.

local mp = require 'mp'
local utils = require 'mp.utils'
local msg = require 'mp.msg'
local assdraw = require 'mp.assdraw'

local opts = {
    --key bindings
    toggle_menu_binding = "ctrl+f",
    up_binding = "UP",
    down_binding = "DOWN",
    select_binding = "ENTER",

    --formatting / cursors
    selected_and_active     = "▶ - ",
    selected_and_inactive   = "● - ",
    unselected_and_active   = "▷ - ",
    unselected_and_inactive = "○ - ",

	--font size scales by window, if false requires larger font and padding sizes
	scale_playlist_by_window=false,

    --playlist ass style overrides inside curly brackets, \keyvalue is one field, extra \ for escape in lua
    --example {\\fnUbuntu\\fs10\\b0\\bord1} equals: font=Ubuntu, size=10, bold=no, border=1
    --read http://docs.aegisub.org/3.2/ASS_Tags/ for reference of tags
    --undeclared tags will use default osd settings
    --these styles will be used for the whole playlist. More specific styling will need to be hacked in
    --
    --(a monospaced font is recommended but not required)
    style_ass_tags = "{\\fnmonospace}",

    --paddings for top left corner
    text_padding_x = 5,
    text_padding_y = 5,

    --other
    menu_timeout = 10,

    --use youtube-dl to fetch a list of available formats (overrides quality_strings)
    fetch_formats = true,

    --default menu entries
    quality_strings=[[
    [
    {"4320p" : "bestvideo[height<=?4320p]+bestaudio/best"},
    {"2160p" : "bestvideo[height<=?2160]+bestaudio/best"},
    {"1440p" : "bestvideo[height<=?1440]+bestaudio/best"},
    {"1080p" : "bestvideo[height<=?1080]+bestaudio/best"},
    {"720p" : "bestvideo[height<=?720]+bestaudio/best"},
    {"480p" : "bestvideo[height<=?480]+bestaudio/best"},
    {"360p" : "bestvideo[height<=?360]+bestaudio/best"},
    {"240p" : "bestvideo[height<=?240]+bestaudio/best"},
    {"144p" : "bestvideo[height<=?144]+bestaudio/best"}
    ]
    ]],
}
(require 'mp.options').read_options(opts, "youtube-quality")
opts.quality_strings = utils.parse_json(opts.quality_strings)

local destroyer = nil


function show_menu()
    local selected = 1
    local active = 0
    local current_ytdl_format = mp.get_property("ytdl-format")
    msg.verbose("current ytdl-format: "..current_ytdl_format)
    local num_options = 0
    local options = {}


    if opts.fetch_formats then
        options, num_options = download_formats()
    end

    if next(options) == nil then
        for i,v in ipairs(opts.quality_strings) do
            num_options = num_options + 1
            for k,v2 in pairs(v) do
                options[i] = {label = k, format=v2}
                if v2 == current_ytdl_format then
                    active = i
                    selected = active
                end
            end
        end
    end

    --set the cursor to the currently format
    for i,v in ipairs(options) do
        if v.format == current_ytdl_format then
            active = i
            selected = active
            break
        end
    end

    function selected_move(amt)
        selected = selected + amt
        if selected < 1 then selected = num_options
        elseif selected > num_options then selected = 1 end
        timeout:kill()
        timeout:resume()
        draw_menu()
    end
    function choose_prefix(i)
        if     i == selected and i == active then return opts.selected_and_active 
        elseif i == selected then return opts.selected_and_inactive end

        if     i ~= selected and i == active then return opts.unselected_and_active
        elseif i ~= selected then return opts.unselected_and_inactive end
        return "> " --shouldn't get here.
    end

    function draw_menu()
        local ass = assdraw.ass_new()

        ass:pos(opts.text_padding_x, opts.text_padding_y)
        ass:append(opts.style_ass_tags)

        for i,v in ipairs(options) do
            ass:append(choose_prefix(i)..v.label.."\\N")
        end

		local w, h = mp.get_osd_size()
		if opts.scale_playlist_by_window then w,h = 0, 0 end
		mp.set_osd_ass(w, h, ass.text)
    end

    function destroy()
        timeout:kill()
        mp.set_osd_ass(0,0,"")
        mp.remove_key_binding("move_up")
        mp.remove_key_binding("move_down")
        mp.remove_key_binding("select")
        mp.remove_key_binding("escape")
        destroyer = nil
    end
    timeout = mp.add_periodic_timer(opts.menu_timeout, destroy)
    destroyer = destroy

    mp.add_forced_key_binding(opts.up_binding,     "move_up",   function() selected_move(-1) end, {repeatable=true})
    mp.add_forced_key_binding(opts.down_binding,   "move_down", function() selected_move(1)  end, {repeatable=true})
    mp.add_forced_key_binding(opts.select_binding, "select",    function()
        destroy()
        mp.set_property("ytdl-format", options[selected].format)
        reload_resume()
    end)
    mp.add_forced_key_binding(opts.toggle_menu_binding, "escape", destroy)

    draw_menu()
    return 
end

local ytdl = {
    path = "youtube-dl",
    searched = false,
    blacklisted = {}
}

format_cache={}
function download_formats()
    local function exec(args)
        local ret = utils.subprocess({args = args})
        return ret.status, ret.stdout, ret
    end

    local function table_size(t)
        s = 0
        for i,v in ipairs(t) do
            s = s+1
        end
        return s
    end

    local url = mp.get_property("path")

    url = string.gsub(url, "ytdl://", "") -- Strip possible ytdl:// prefix.

    -- don't fetch the format list if we already have it
    if format_cache[url] ~= nil then 
        local res = format_cache[url]
        return res, table_size(res)
    end
    mp.osd_message("fetching available formats with youtube-dl...", 60)

    if not (ytdl.searched) then
        local ytdl_mcd = mp.find_config_file("youtube-dl")
        if not (ytdl_mcd == nil) then
            msg.verbose("found youtube-dl at: " .. ytdl_mcd)
            ytdl.path = ytdl_mcd
        end
        ytdl.searched = true
    end

    local command = {ytdl.path, "--no-warnings", "--no-playlist", "-J"}
    table.insert(command, url)
    local es, json, result = exec(command)

    if (es < 0) or (json == nil) or (json == "") then
        mp.osd_message("fetching formats failed...", 1)
        msg.error("failed to get format list: " .. err)
        return {}, 0
    end

    local json, err = utils.parse_json(json)

    if (json == nil) then
        mp.osd_message("fetching formats failed...", 1)
        msg.error("failed to parse JSON data: " .. err)
        return {}, 0
    end

    res = {}
    msg.verbose("youtube-dl succeeded!")
    for i,v in ipairs(json.formats) do
        if v.vcodec ~= "none" then
            local fps = v.fps and v.fps.."fps" or ""
            local resolution = string.format("%sx%s", v.width, v.height)
            local l = string.format("%-9s %-5s (%-4s / %s)", resolution, fps, v.ext, v.vcodec)
            local f = string.format("%s+bestaudio/best", v.format_id)
            table.insert(res, {label=l, format=f, width=v.width })
        end
    end

    table.sort(res, function(a, b) return a.width > b.width end)

    mp.osd_message("", 0)
    format_cache[url] = res
    return res, table_size(res)
end


-- register script message to show menu
mp.register_script_message("toggle-quality-menu", 
function()
    if destroyer ~= nil then
        destroyer()
    else
        show_menu()
    end
end)

-- keybind to launch menu
mp.add_key_binding(opts.toggle_menu_binding, "quality-menu", show_menu)

-- special thanks to reload.lua (https://github.com/4e6/mpv-reload/)
function reload_resume()
    local playlist_pos = mp.get_property_number("playlist-pos")
    local reload_duration = mp.get_property_native("duration")
    local time_pos = mp.get_property("time-pos")

    mp.set_property_number("playlist-pos", playlist_pos)

    -- Tries to determine live stream vs. pre-recordered VOD. VOD has non-zero
    -- duration property. When reloading VOD, to keep the current time position
    -- we should provide offset from the start. Stream doesn't have fixed start.
    -- Decent choice would be to reload stream from it's current 'live' positon.
    -- That's the reason we don't pass the offset when reloading streams.
    if reload_duration and reload_duration > 0 then
        local function seeker()
            mp.commandv("seek", time_pos, "absolute")
            mp.unregister_event(seeker)
        end
        mp.register_event("file-loaded", seeker)
    end
end
