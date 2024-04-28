#!/bin/bash
INIT_LOGFILE () {
	echo $"~~~~~~~~~~~~Recent commit history~~~~~~~~~~~~ " > timegit.log
	echo $" " >> timegit.log
	git log >> timegit.log
}

DEL_LOGFILE () {
	rm timegit.log
}

INIT_LOGFILE

MAIN_MENU() {
	exec 3>&1

	CUSTOM_DATE=$(dialog --erase-on-exit --ok-label "OK"  --exit-label "OK" \
		--backtitle "git-time"\
		--title "" \
		--tailbox timegit.log 40 80\
		--and-widget \
		--form "Custom commit date" \
	15 50 0 \
		"Edit" 1 1	"$(date "+%c")" 	2 1 40 0 \
	2>&1 1>&3)

	exec 3>&-
	ERROR=$(date --date="$CUSTOM_DATE" --debug  2>&1 | grep error)
	ERROR_LENGTH=$(expr length "$ERROR")

}

ERROR_MENU() {
	dialog --erase-on-exit --backtitle "git-time" \
    --title "Date input invalid, please confirm to correct" \
    --msgbox "$1" 20 80\

}

MAIN_MENU


while [ $ERROR_LENGTH -gt 0 ]
do
	ERROR_MENU "$ERROR"
	MAIN_MENU
done


DEL_LOGFILE

echo "$@"


NEW_DATE=$(date --date="$CUSTOM_DATE")
GIT_AUTHOR_DATE=$NEW_DATE GIT_COMMITTER_DATE=$NEW_DATE git "$@"
exit
