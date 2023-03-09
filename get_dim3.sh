#!/bin/zsh

# filename: get_dim3
# Author: D. Chandonnet
# Fri 24 Feb 2023 14:59:16 EST
# Purpose is to sort photos by width dimensions
# -it sorts the folder into three sizes
# -it renames the photos prefixed by their width dimensions
#
# =========================================
#
# USAGE:
#
# PROBLEMS
# - subdirectories are read
# -gif files produce many dimensions
# -new filename does not work
#
#
#
#
#
#
#
#
#
#
# =========================================
#!/bin/bash

# Define the input folder
# input_folder="$1"
input_folder="/Users/MAC_at_home/iPad/photo1"

# Define the output sub-directories
large_folder="$input_folder/large_photos"
medium_folder="$input_folder/medium_photos"
small_folder="$input_folder/small_photos"

# Create the output sub-directories
mkdir -p "$large_folder" "$medium_folder" "$small_folder"

# Create the text file listing
output_file="$input_folder/photo_dimensions.txt"



echo "Photo Name | Width (px)" > "$output_file"



# Loop over all image files in the input folder
# maxdepth 1 makes find ignor the sub directories
find "$input_folder" -maxdepth 1 -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" | while read file
do
  # Get the width of the image file
  width=$(identify -format "%w" "$file")

  # to see if width is taken
  # echo "$width"

#test to see if I can create a new name
# remove the path with basename
newf=$(basename "$file")
# concatinate the variables to create new filename
newfile="${width}_${newf}"
echo "$newfile"

# echo "Width: $width"
  # Determine which output sub-directory to use based on the width
  if [ $width -gt 1920 ]; then
    output_folder="$large_folder"
  elif [ $width -gt 600 ]; then
    output_folder="$medium_folder"
  else
    output_folder="$small_folder"
  fi
# echo "Output folder: $output_folder"

  # Move the image file to the appropriate output sub-directory
  mv "$file" "$newfile"
  mv "$newfile" "$output_folder"

  # Write the photo name and width to the output file
  # basename removes the path from the name
  echo "$(basename "$file") | $width" >> "$output_file"
  echo "$width"
done
