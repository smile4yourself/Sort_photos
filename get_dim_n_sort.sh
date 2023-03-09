#!/bin/zsh -x

# filename: get_dim_n_sort
# Author: D. Chandonnet
# Tues Mar 7 2023 14:59:16 EST
#
# Purpose:
# to sort photos by quality using the image width from ImageMajic
# the photos are processed, their name changed (with their width prefixing the file name)
# and then they are moved into a folder of similaly sized photos:
#
# /Users/MAC_at_home/SORT/inbox
# /Users/MAC_at_home/SORT/mp3
# /Users/MAC_at_home/SORT/Gifs
# /Users/MAC_at_home/SORT/2000
# /Users/MAC_at_home/SORT/1000
# /Users/MAC_at_home/SORT/900
# /Users/MAC_at_home/SORT/800
# /Users/MAC_at_home/SORT/700
# /Users/MAC_at_home/SORT/600
# /Users/MAC_at_home/SORT/500
# /Users/MAC_at_home/SORT/400
# /Users/MAC_at_home/SORT/300
# /Users/MAC_at_home/SORT/200
#
#
# This script resides in Documents/scripts on my MAC
# Run these scripts from this directory for testing.
# =========================================
#
# USAGE: get_dim_n_sort folder
#
# PROBLEMS
# - subdirectories are read; fixed with maxdepth 1
# -gif files produce many dimensions
# =========================================

# used in Mac Quick Actions
 # export PATH=/usr/local/bin:$PATH

# Define the input folder for testing
# input_folder="$1"
# input_folder="/Users/MAC_at_home/SORT/inbox"

input_folder="/Users/MAC_at_home/iPad/test"
# Define the input folder as a parm once script works
# so it can be loaded in automator, and added to Quick Actions on the MAC
# input_folder="$1"

#===================== Logfile =================
# turn loging "ON" or "OFF"
# set logging on or off
 # logging="y"
logging="n"

# set the name and location of the logfile
logfile="/Users/MAC_at_home/Documents/Scripts/logfile.txt"

# print the top matter of log file if loging is == y
# rename the logfile if loging is == n

# use this form of if to compare two string variables
if [[ $logging == "y" ]]
then
  echo "Name of this script: $0" >>$logfile
  date | >>$logfile
  echo ""  >>$logfile
else [ $logging = "n" ]
  cp logfile.txt logfile.bak
fi
#===================== Logfile =================

#===================== Functions =================

# print_log function
# send four items to the log file
# they can be variable names or the contents
# print_log varname $varname

function print_log {
if [[ $logging == "y" ]]
then
echo $1 $2 $3 $4 >> logfile.txt
else
fi
 }
#---------------------------------
# check if $1 is a directory ; if not quality


print_log $LINENO input_folder $input_folder "------this_is_\$1-------"


# =========================================
# Define the output variables for sub-directory names
# this is where the processed photos will be placed

folder_2000="/Users/MAC_at_home/SORT/2000"
folder_1000="/Users/MAC_at_home/SORT/1000"
folder_900="/Users/MAC_at_home/SORT/900"
folder_800="/Users/MAC_at_home/SORT/800"
folder_700="/Users/MAC_at_home/SORT/700"
folder_600="/Users/MAC_at_home/SORT/600"
folder_500="/Users/MAC_at_home/SORT/500"
folder_400="/Users/MAC_at_home/SORT/400"
folder_300="/Users/MAC_at_home/SORT/300"
folder_200="/Users/MAC_at_home/SORT/200"

# "folder_Gifs" will be used for Gifs
folder_Gifs="/Users/MAC_at_home/SORT/Gifs_to_sort"
folder_mp4="/Users/MAC_at_home/SORT/mp4"

# echo "$folder_2000"
# echo "$folder_900"
#print_log $LINENO folder_2000 $folder_2000
#print_log $LINENO folder_1000 $folder_1000
#print_log $LINENO folder_900 $folder_900
#print_log $LINENO folder_800 $folder_800
#print_log $LINENO folder_700 $folder_700
#print_log $LINENO folder_600 $folder_600
#print_log $LINENO folder_500 $folder_500
#print_log $LINENO folder_400 $folder_400
#print_log $LINENO folder_300 $folder_300
#print_log $LINENO folder_200 $folder_200

#print_log $LINENO folder_Gifs $folder_Gifs
#print_log $LINENO folder_mp4 $folder_mp4




# Create the output sub-directories
# I did this manually
# mkdir -p "$2000_folder" etc when required

# Create the text file listing for debugging
# output_file="$input_folder/photo_dimensions.txt"
# echo "Photo Name | Width (px)" > "$output_file"

# ---------------------------------------
#
#          Move Gifs and mp3s
#
# ---------------------------------------


find "$input_folder" -maxdepth 1 -type f -iname "*.gif"  | while read file

do
echo $file
mv $file /Users/MAC_at_home/SORT/Gifs_to_sort
done

find "$input_folder" -maxdepth 1 -type f -iname "*.mp4"  | while read file

do
echo $file
mv $file /Users/MAC_at_home/SORT/mp4
done


print_log $LINENO MAIN LOOP
# ---------------------------------------
#
#           MAIN Loop
#
# ---------------------------------------
# Loop over all image files in the input folder

# read image file in the input folder
# maxdepth 1 makes find ignor the sub directories
# find "$input_folder" -maxdepth 1 -type f -iname "*.jpg"  -iname "*.jpeg"  -iname  "*.png"  | while read file

find "$input_folder" -maxdepth 1 -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png"  | while read file



do
print_log $LINENO Input_photo $file

  # set var "width" with the width-value of the image file using "identify" a cmd of ImageMajic
  width=$(identify -format "%w" "$file")

print_log Width: $LINENO $width

# remove the path from the file var with basename
newf=$(basename "$file")

print_log $LINENO newf: $newf

# concatinate the width variable to the filename to create a new filename
newfile="${width}_${newf}"
print_log $LINENO newfile: $newfile


# get the path part of the file name
DIR="$(dirname "${file}")"
#echo "$DIR"

print_log DIR $DIR

# add the path to the new filename
newfile2="${DIR}/${newfile}"

#print_log --------------DIR_plus_width_plus_file--------------
#print_log $LINENO $newfile2 $newfile2



# set the output_folder variable based on the type and width



if [ $width -gt 1999 ]; then
    output_folder="$folder_2000"
elif [ $width -gt 999 ]; then
    output_folder="$folder_1000"
elif [ $width -gt 899 ]; then
      output_folder="$folder_900"
elif [ $width -gt 699 ]; then
      output_folder="$folder_700"
elif [ $width -gt 599 ]; then
        output_folder="$folder_600"
elif [ $width -gt 499 ]; then
        output_folder="$folder_500"
elif [ $width -gt 399 ]; then
        output_folder="$folder_400"
elif [ $width -gt 299 ]; then
        output_folder="$folder_300"
elif [ $width -lt 300 ]; then
        output_folder="$folder_200"

fi


# ==================================================
print_log $LINENO $file $newfile2

# Rename the photo to include the width dimensions
  mv "$file" "$newfile"

# echo "newfile is: $newfile"

# move the file into the correct folder based on the value of output_folder
  mv "$newfile" "$output_folder"

#  # Write the photo name and width to the output file
#  # basename removes the path from the name
#  echo "$(basename "$file") | $width" >> "$output_file"
#  echo "$width"

done
