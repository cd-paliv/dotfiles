#!/bin/bash
~/.config/scripts/specialchars.py &
pid="$!"

# Wait for the window to open and grab its window ID
winid=''
while : ; do
    winid="`wmctrl -lp | awk -vpid=$pid '$3==pid {print $1; exit}'`"
    [[ -z "${winid}" ]] || break
done

# Focus the window we found
wmctrl -ia "${winid}"

# Make it float
i3-msg floating enable > /dev/null;

# Move it to the center for good measure
i3-msg move position center > /dev/null;

# move mouse to center
xdotool mousemove 960 540

# Wait for the application to quit
wait "${pid}";
