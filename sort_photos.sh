#!/bin/sh

# filename: sort_photos
# Author: D. Chandonnet
# Fri 24 Feb 2023 12:52:53 EST
# The purpose of this script is to ...
# This script resides in Documents/scripts on my MAC
# Run these scripts from this directory.

# request to https://chat.openai.com/chat:
# write me a shell script for the mac which uses a folder as the input.
# The folder will contain photos to be sorted by the width of the image sizes.
# The shell should sort the photos and place them in sub-directories
# within the initial folder. Using the photo widths noted below,
# create /large_photos, /medium_photos, /small_photos.
# Large photos have a width greater than 1920,
# medium photos have a width greater than 600 but less than 1920,
# small photos will have a width less than 600.
# =========================================
#
# USAGE:sort_photos /directory_name
#
#
# =========================================



# Define the input folder
input_folder="$1"

# Define the output sub-directories
large_folder="$input_folder/large_photos"
medium_folder="$input_folder/medium_photos"
small_folder="$input_folder/small_photos"

mkdir -p "$text_output_folder"

# Create the output sub-directories
mkdir -p "$large_folder" "$medium_folder" "$small_folder"

chmod 777 "$large_folder" "$medium_folder" "$small_folder"
# Loop over all image files in the input folder
find "$input_folder" -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" | while read file
do
  # Get the width of the image file
  width=$(identify -format "%w" "$file")

  # Determine which output sub-directory to use based on the width
if [ -n "$width" ] && [ "$width" -gt 1920 ]; then
    output_folder="$large_folder"
  elif [ -n "$width" ] && [ $width -gt 600 ]; then
    output_folder="$medium_folder"
  else
    output_folder="$small_folder"
  fi

  # Create output directory if it does not exist
 mkdir -p "$output_folder"


  # Move the image file to the appropriate output sub-directory
  mv "$file" "$output_folder"

  # Write the photo name and width to the output file
echo "$(basename "$file") | $width" >> "image_widths.txt"

done
