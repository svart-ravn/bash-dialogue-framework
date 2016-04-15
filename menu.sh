#!/bin/bash


STTY_SAVED=

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

Here is the sample menu script. 

Please choose something:
[1] Choice 1
[2] Choice 2
[x] Exit
[?] Will try to help you

END
}


function get_user_choice(){
   read KEYPRESSED

   case $KEYPRESSED in
      "");;
      1) ./choice1/menu.sh;;
      2) ./choice2/menu.sh;;
      "x") exit 0;;
      "?") echo "no help here";;
   esac
}


function init(){
   local RC=0
   if [ ! -t 0 ]; then
      echo "This script should be executed only in interactive mode"
      RC=1
   fi

   STTY_SAVED=$(stty -g)
   tput civis
   trap on_exit EXIT
   stty -echo -icanon time 0 min 0

   return $RC
}


function on_exit(){
   tput cnorm
   stty $STTY_SAVED
}


# ------------------------ MAIN ---------------------------------------
init || exit 1


show_menu

echo "Thanks for trying to be a pirate"

exit 0