#!/bin/bash


# ---------------------------------------------------------------------
function show_menu(){
   HOME_CMD=$(tput cup 0 0)
   ED=$(tput ed)
   EL=$(tput el)
   
   printf '%s%s' "$HOME_CMD" "$ED"

   while :; do 
      ROWS=$(tput lines)
      COLS=$(tput cols)
      menu | head -n $ROWS | while IFS= read LINE; do
         printf '%-*.*s%s\n' $COLS $COLS "$LINE" "$EL"
      done
      get_user_choice
      printf '%s%s' "$ED" "$HOME_CMD"
      sleep 1
   done
}



# ---------------------------------------------------------------------
function menu(){
cat << END

Are you pirate?
[y] Yes
[n] No
[x] Exit
[?] Will try to help you

END
}


function get_user_choice(){
   read KEYPRESSED

   case $KEYPRESSED in
      "");;
      "y") echo "Great";;
      "n") echo "So sad :(";;
      "x") exit 0;;
      "?") echo "you'd better be a pirate";;
   esac
}


function init(){
   local RC=0
   if [ ! -t 0 ]; then
      echo "This script should be executed only in interactive mode"
      RC=1
   fi
   
   stty -echo -icanon time 0 min 0

   return $RC
}


# ------------------------ MAIN ---------------------------------------
init || exit 1

show_menu

exit 0