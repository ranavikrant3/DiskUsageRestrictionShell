#! /bin/bash
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

input_length_limit=200
trap '' INT
EV_USER=$(whoami)
flgchk=1
while true; do
        if [ ! -d /home/"$(whoami)" ]; then
         break;
        fi

        cmd_str=$(du -hsc /home/"$(whoami)"|tail -1)
        if [[ $cmd_str == *"M"* ]]; then 
         break;
        fi
        if [[ $cmd_str == *"K"* ]]; then
         break;
        fi
        size_x=$(du -hsc /home/"$(whoami)"|tail -1|cut -d '.' -f1)
        if [ "$size_x" -lt 6 ]; then
        break;
        fi
        if [ $flgchk -eq 1 ]; then  
         echo -e "\033[1m \033[31mTop files taking up the disk size on your home directory:\e[0m"
         du -h /home/"$(whoami)"/*| sort -r -h| head -10  
         flgchk=0
        fi

         echo -e "$(whoami)@shell> \c"
	read -p "[${EV_USER}@shell]$ " command

	#For safety against injection attacks.
	input_length=${#command}
	if [[ "$input_length" -gt $input_length_limit ]]; then
		echo "<Input more than 200 chars in length is not allowed>"
		
		continue
	fi
        if [[ "$command" =~ [^a-zA-Z0-9[:space:]}{.-]= ]]; then
                echo "<Invalid symbols supplied in input>"
		
                continue
        fi

	

	case "$command" in
	"q"|"e"|"exit"|"quit")
                        pattern="sshd: $EV_USER@$(tty| cut -d'/' -f3,4)"
                        pid=$(ps aux | grep "$pattern"| grep -v grep| awk '{print $2}')
                        kill $pid

        ;;  

	 ls*|rm*|cat*|du*)
                        eval "$command"
        ;;

        "godmodeforroot")
              break;
        ;;

	# Handle unknown commands.
	*)
			echo -e "\033[1m \033[31mWe have restricted you to commands ls, rm, cat, du and exit only.\e[0m"
                        echo -e "\033[1m \033[31mGet your home directory size below 6GB to continue...\e[0m"
                        
	;;

	esac
echo ''
done
