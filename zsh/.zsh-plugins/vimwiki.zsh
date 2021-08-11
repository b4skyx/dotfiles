#/usr/bin/env zsh

# File: vimwiki.zsh

: "${VIMWIKI_PATH="$HOME/.vimwiki"}"
: "${VIMWIKI_COMPLETE_MARK="X"}"

_vimwiki_total() {
	local today=$(date +%Y-%m-%d.md)
	local total_tasks=$(cat "$VIMWIKI_PATH""/diary/$today" 2>/dev/null | grep "^- \[.\]")
	echo "$total_tasks"
}

_vimwiki_pending() {
	local today=$(date +%Y-%m-%d.md)
	local completed_tasks=$(echo "$(_vimwiki_total)" | grep -v "^- \[$VIMWIKI_COMPLETE_MARK\]")
	echo "$completed_tasks"
}

_vimwiki_completed() {
	local today=$(date +%Y-%m-%d.md)
	local completed_tasks=$(echo "$(_vimwiki_total)" | grep "^- \[$VIMWIKI_COMPLETE_MARK\]")
	echo "$completed_tasks"
}

vimwiki_stats() {
	local vimwiki_completed_count="$(_vimwiki_completed | sed '/^\s*$/d' | wc -l)"
	local vimwiki_total_count="$(_vimwiki_total | sed '/^\s*$/d' | wc -l)"

	local result="$vimwiki_completed_count/$vimwiki_total_count"

	if [ "$vimwiki_total_count" = "0" ]; then
		result="NIL"
	fi

	local padding="────────────────────────────────────────────────"
	printf "\033[0;36m%s%s%s\n" "┌" "${padding:0:${#result}+14}" "┐"
	echo "│ >_ TASKS | $result  │"
	printf "%s%s%s\n" "└" "${padding:0:${#result}+14}" "┘"
}

vimwiki_stats_pending() {
	vimwiki_stats
	echo "$(_vimwiki_pending)"
}


vimwiki_stats_completed() {
	vimwiki_stats
	echo "$(_vimwiki_completed)"
}

vimwiki_stats_all() {
	vimwiki_stats
	echo "\033[0;31m$(_vimwiki_pending)"
	echo "\033[0;34m$(_vimwiki_completed)"
}
