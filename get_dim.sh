#!/bin/sh

# get the widthxheight dimensions of an image and
# append that to the file's basename.
# Legend: a = absolute path, a:r = path and basename, a:e = extension
#
# Usage: dim.zsh image1.ext image2.ext ... imagen.ext

for f in "$@"
do
    # generate widthxheight string by joining array elements w/'x' as separator
    wxh=${(j:x:)$(/usr/bin/sips -g pixelWidth -g pixelHeight ${f:a} |\
        /usr/bin/awk '{getline;print $2}')}
    # rename to foo wxh.ext
    /bin/mv "${f:a}" "${f:a:r} ${wxh}.${f:a:e}"
done
