#!/bin/bash

# Download ffmpeg MacOS binary
curl -O https://raw.githubusercontent.com/wearemieta/ishoot/master/bin/ffmpeg;

# Setup working dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR;

# Create .ts files
for file in *.mov;
	do ffmpeg -i "$file" -c copy -bsf:v h264_mp4toannexb -f mpegts "${file%.mov}".ts;
done;

# Merge .ts and render as mp4
ffmpeg -f concat -i <(for f in *.ts; do echo "file '$(pwd)/$f'"; done) -c copy -bsf:a aac_adtstoasc output.mp4;

# Remove unused .ts
rm -rf *.ts;

# Exit
echo "All done";
exit 0
