#!/bin/bash
echo -e "\n~~~~~ Schedule your commit dates  ~~~~~"

LAST_COMMIT=$(git log -1)

LAST_COMMIT_SECONDS=$(git log -1 --format="%at")

LAST_COMMIT_TIME=$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y/%m/%d_%H:%M:%S)

NOW_EPOCH=$(date +%s)

YEAR_DELTA=0
DAY_DELTA=0
HOUR_DELTA=0
MINUTE_DELTA=0
SECOND_DELTA=0

while getopts ":y::d::h::m::s:" opt; do
  case $opt in
    y)
      YEAR_DELTA=$OPTARG
      ;;
    d)
      DAY_DELTA=$OPTARG
      ;;
    h)
      HOUR_DELTA=$OPTARG
      ;;
    m)
      MINUTE_DELTA=$OPTARG
      ;;
    s)
      SECOND_DELTA=$OPTARG
      ;;
    
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

TOTAL_SECONDS_OFFSET=$(($YEAR_DELTA*365*24*60*60+$DAY_DELTA*24*60*60+$HOUR_DELTA*60*60+$MINUTE_DELTA*60+$SECOND_DELTA))

NEW_COMMIT_TIME=$((- $TOTAL_SECONDS_OFFSET))
NEW_COMMIT_DATE=$(date -d "$NEW_COMMIT_TIME seconds")
echo Your new commit date is $NEW_COMMIT_DATE, proceed?
read INPUT
if [[ $INPUT == "Y" ]]
then echo Enter your commit message
read COMMIT_MESSAGE
GIT_AUTHOR_DATE=$(($(date +%s)  - $TOTAL_SECONDS_OFFSET)) GIT_COMMITTER_DATE=$(($(date +%s) - $TOTAL_SECONDS_OFFSET))  git commit -m "$COMMIT_MESSAGE"
fi
