#!/bin/bash

# This script is intended to be mapped to keyboard shortcuts, allowing
# Guake users to increase or decrease their font size without having to
# launch the Guake preferences dialog. 
# At the time of writing I used <Ctrl><Shift>+ and <Ctrl><Shift>-       

# One mandatory argument with value only two valid values
if ([ "$1" != "decrease" ] && [ "$1" != "increase" ]); then
    echo "Usage: guake-font-size increment|decrement"
    exit
fi

# Get the relevant Gnome config key value
STYLE=`gconftool-2 --get /apps/guake/style/font/style`

# Extract the size using shell parameter expansion
# to get the last space-separated word from the string
CURRENT_SIZE=${STYLE##* }

# Increment/decrement the current size using arithmetic expansion
if [ $1 = "increase" ]; then
    NEW_SIZE=$((CURRENT_SIZE + 1))
else
    NEW_SIZE=$((CURRENT_SIZE - 1))
fi

# Form the new Gnome config key value, again using shell 
# parameter expansion 
NEW_STYLE="${STYLE% *} ${NEW_SIZE}"

# Apply the new style
gconftool-2 --type string --set /apps/guake/style/font/style "${NEW_STYLE}"

exit
