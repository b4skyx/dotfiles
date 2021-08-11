--[[
    script to cycle profiles with a keybind, accomplished through script messages
    available at: https://github.com/CogentRedTester/mpv-scripts
    syntax:
        script-message cycle-profiles "profile1;profile2;profile3"
    You must use semicolons to separate the profiles, do not include any spaces that are not part of the profile name.
    The script will print the profile description to the screen when switching, if there is no profile description, then it just prints the name
]]--

--change this to change what character separates the profile names
seperator = ";"

msg = require 'mp.msg'

--splits the profiles string into an array of profile names
--function taken from: https://stackoverflow.com/questions/1426954/split-string-in-lua/7615129#7615129
function mysplit (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

--table of all available profiles and options
profileList = mp.get_property_native('profile-list')

--keeps track of current profile for every unique cycle
iterator = {}

--stores descriptions for profiles
--once requested a description is stored here so it does not need to be found again
profilesDescs = {}

--if trying to cycle to an unknown profile this function is run to find a description to print
function findDesc(profile)
    msg.verbose('unknown profile ' .. profile .. ', searching for description')

    for i = 1, #profileList, 1 do
        if profileList[i]['name'] == profile then
            msg.verbose('profile found')
            local desc = profileList[i]['profile-desc']

            if desc ~= nil then
                msg.verbose('description found')
                profilesDescs[profile] = desc
            else
                msg.verbose('no description, will use name')
                profilesDescs[profile] = profile
            end
            return
        end
    end

    msg.verbose('profile not found')
    profilesDescs[profile] = "no profile '" .. profile .. "'"
end

--prints the profile description to the OSD
--if the profile has not been requested before during the session then it runs findDesc()
function printProfileDesc(profile)
    local desc = profilesDescs[profile]
    if desc == nil then
        findDesc(profile)
        desc = profilesDescs[profile]
    end

    msg.verbose('profile description: ' .. desc)
    mp.osd_message(desc)
end

function main(profileStr)
    --if there is not already an iterator for this cycle then it creates one
    if iterator[profileStr] == nil then
        msg.verbose('unknown cycle, creating new iterator')
        iterator[profileStr] = 1
    end
    local i = iterator[profileStr]

    --converts the string into an array of profile names
    local profiles = mysplit(profileStr, seperator)
    msg.verbose('cycling ' .. tostring(profiles))
    msg.verbose("number of profiles: " .. tostring(#profiles))

    --sends the command to apply the profile
    msg.info("applying profile " .. profiles[i])
    mp.commandv('apply-profile', profiles[i])

    --prints the profile description to the OSD
    printProfileDesc(profiles[i])

    --moves the iterator
    iterator[profileStr] = iterator[profileStr] + 1
    if iterator[profileStr] > #profiles then
        msg.verbose('reached end of profiles, wrapping back to start')
        iterator[profileStr] = 1
    end
end

mp.register_script_message('cycle-profiles', main)
