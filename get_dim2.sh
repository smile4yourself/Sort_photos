#!/bin/sh

# filename: get_dim2
# Author: D. Chandonnet
# Fri 24 Feb 2023 14:25:28 EST
# The purpose of this script is to get photo dimensions using "identify"
# This script resides in Documents/scripts on my MAC
# Run these scripts from this directory.
#
# do not use on gif files
# =========================================
#
# USAGE: 1. set folder to check
#        2. save script
#        3. ./get_dim2
# =========================================


# Define the folder containing the photos
input_folder="/Users/MAC_at_home/iPad/photo2"


#bash#!/bin/bash

# Define the input folder
#input_folder="$1"

# Define the output sub-directories
large_folder="$input_folder/large_photos"
medium_folder="$input_folder/medium_photos"
small_folder="$input_folder/small_photos"

# Create the output sub-directories
mkdir -p "$large_folder" "$medium_folder" "$small_folder"

# Loop over all image files in the input folder
# I added maxdepth -1 (this was not from the bot)
find "$input_folder"  -maxdepth 1 -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" | while read file

do
  # Get the width of the image file
  width=$(identify -format "%w" "$file")

  # Determine which output sub-directory to use based on the width
  if [ $width -gt 1920 ]; then
    output_folder="$large_folder"
  elif [ $width -gt 600 ]; then
    output_folder="$medium_folder"
  else
    output_folder="$small_folder"
  fi

  # Move the image file to the appropriate output sub-directory
  mv "$file" "$output_folder"
done
