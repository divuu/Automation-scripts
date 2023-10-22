#!/bin/bash

# Calculate the timestamp for 7 days ago
timestamp=$(date -d "7 days ago" +%s)
# echo $timestamp

# Find files in the directory
files=$(find -name "loadtest*" -type f)
# echo $files

# Loop through each file and check if it is older than 7 days
for file in $files; do
  file_timestamp=$(date -r "$file" +%s)
        # echo $file_timestamp
  if [ "$file_timestamp" -le "$timestamp" ]; then
        # echo "identified files ==> $files"
        # rm -rf "$file"
    echo "--------------------------------------------------------------------"
    echo "Identified 7Day old file: $file"
    echo "--------------------------------------------------------------------"
  fi
done
