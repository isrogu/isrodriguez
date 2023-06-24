#!/bin/bash

count_lines_by_month() {
    local month="$1"
    local txt_files="*.txt"

    echo "Files created on $month:"

    for file in $txt_files; do
        local creation_month=$(stat -c '%y' "$file" | awk -F'-' '{print $2}')
        if [[ $creation_month == $month ]]; then
            local file_lines=$(wc -l < "$file")
            echo "$file: $file_lines lines"
        fi
    done
}

while getopts ":m:" opt; do
  case $opt in
    m)
      specified_month="$OPTARG"
      ;;
    \?)
      echo "Month Number no valid: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [[ -n $specified_month ]]; then
    count_lines_by_month "$specified_month"
else
    echo "Insert a valid month number after -m"
    exit 1
fi
