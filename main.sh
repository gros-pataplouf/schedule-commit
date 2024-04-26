#!/bin/bash
echo -e "\n~~~~~ Schedule your commit dates  ~~~~~"

git log -1 --format="%at" | xargs -I{} date -d @{} +%Y/%m/%d_%H:%M:%S

