#!/bin/zsh

# filename: get_dim4
# Author: D. Chandonnet
# Fri 24 Feb 2023 14:59:16 EST
#
# Purpose is to sort photos by width dimensions
# -it uses a directory of photos as it's input
# -it renames the files prefixing the filename with the width dimension
# -it moves the new files into "sized_photos" within the directory of photos
#
# This script resides in Documents/scripts on my MAC
# Run these scripts from this directory.
# =========================================
#
# USAGE: get_dim4 /folder
#
#    I added it to the mac's Quick Actions by
#         1. opening Automator,
#         2. selecting Quick Actions
#         3. add RUN SHELL script
#         4. set it to receive "files or folders" in "Finder app"
#         5. copy and paste the script into the Workflow
#         6. shell: /bin/zsh  Pass input as arguments
#         7. uncomment line 29 here
#
#
# ============ ideas to add ===============
#
#  - a log files
#  - BMP files
#  - auto sort by size to folders
#  - convert HEIC to JPG
#  - convert WEP
# =========================================
# used in Mac Quick Actions
# export PATH=/usr/local/bin:$PATH





# Define the input folder
input_folder="$1"

# for testing
# input_folder="/Users/Mac_at_Home/iPad/photo1"

# Create the outputdirectory for renamed files
output_folder="$input_folder/sized_photos"
mkdir -p "$output_folder"

# Create the text file listing for debugging
# output_file="$input_folder/photo_dimensions.txt"
# echo "Photo Name | Width (px)" > "$output_file"


# ---------------------------------------
#
#           MAIN Loop
#
# ---------------------------------------
# Loop over all image files in the input folder
# maxdepth 1 makes find ignor the sub directories
find "$input_folder" -maxdepth 1 -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" | while read file
do
  # Get the width of the image file
  width=$(identify -format "%w" "$file")
  # ---------------------------
  # to see if width is taken
  # echo "$width"
  # ---------------------------

# remove the path from the file var with basename
newf=$(basename "$file")

# concatinate the variables to create new filename prepended by width
newfile="${width}_${newf}"

# get the path part of the file name
DIR="$(dirname "${file}")"

# add the path to the new filename
newfile2="${DIR}/${newfile}"

# echo "$newfile2"


# echo for debugging
# echo "$newfile"
# echo "Width: $width"


# echo for debugging
# echo "Output folder: $output_folder"

DIR="$(dirname "${file}")"
echo "-------$ DIR -------------"
echo "$DIR"
echo "-------$ file-------------"
echo "$file"
echo "-------newf-------------"
echo "$newf"
echo "-------newfile2-------------"
echo "$newfile2"
echo "-------out folder---------------------"
echo "$output_folder"
echo "----------------------------"

  # Move the image file to the appropriate output sub-directory
   mv -n "$file" "$newfile2"
   mv "$newfile2" "$output_folder"

  # Write the photo name and width to the output file
  # basename removes the path from the name
  # echo "$(basename "$file") | $width" >> "$output_file"
  # echo "$width"
done
# end of loop ------------------------------------------------
