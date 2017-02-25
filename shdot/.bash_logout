set -o nounset     # Strict var declare
set -o errexit     # Exit on error

#.bash_logout - is executed by bash when login shell exits, 
# and that code from your question intends to clear the screen 
# to increase privacy when leaving the console.

# SHLVL is a environment variable which came from "SHell LeVeL" 
# and lets you track how many subshells deep your current shell is. 
# In your top-level shell, the value of $SHLV is 1. 
# In the first subshell, it's 2; in a sub-subshell, it's 3; and so on. 
# So SHLVL indicates how many shells deep the user is. 
# If the level is 2, you must type exit, then logout to exit.

# clear_console is very approached to clear command which can be used in any terminal/console.

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
