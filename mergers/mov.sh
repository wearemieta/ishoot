#!/bin/bash

# Setup working dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR;

# Create local bin directory
mkdir bin;

# Download ffmpeg MacOS binary
curl -o bin/ffmpeg https://raw.githubusercontent.com/wearemieta/ishoot/master/bin/ffmpeg;

# Change permissions for ffmpeg
chmod +x bin/ffmpeg

# Create .ts files
for file in *.mov;
	do bin/ffmpeg -i "$file" -c copy -bsf:v h264_mp4toannexb -f mpegts "${file%.mov}".ts;
done;

# Merge .ts and render as mp4
bin/ffmpeg -f concat -safe 0 -i <(for f in *.ts; do echo "file '$(pwd)/$f'"; done) -c copy -bsf:a aac_adtstoasc output.mp4;

# Remove unused .ts
rm -rf *.ts;

# Exit
echo "All done";
exit 0
