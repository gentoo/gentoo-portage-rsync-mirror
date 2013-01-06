#!/bin/bash
# Wrapper script for conkeror

xr=$(type -p firefox)
[[ -n ${xr} ]] && exec "${xr}" -app /usr/share/conkeror/application.ini "$@"
echo "$0: firefox required, but not found." >&2
exit 1
