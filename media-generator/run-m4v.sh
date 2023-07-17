#!/usr/bin/env bash
#set -e

#OUTPUT_DIR="$1"
OUT="$(mktemp $OUTPUT_DIR/output.XXXXXXXXXX.m4v)"
#TEXT_DATA_AS_FILE="$(mktemp $OUTPUT_DIR/output.XXXXXXXXXX.txt)"
#echo $GEN_TEXT > $TEXT_DATA_AS_FILE
#ffmpeg -y -f lavfi -i color=size=640x480:rate=30 \
#-vf "drawtext=textfile='$TEXT_DATA_AS_FILE':x=10:y=480:fontfile=/usr/share/fonts/truetype/SpaceMono-Regular.ttf:fontsize=10:text_wrap=30:line_spacing=10:fontcolor=black" \
#-c:v libx264 -pix_fmt yuv420p $OUT  &>/dev/null

ffmpeg \
  -nostats  -hide_banner -loglevel panic \
-y -f lavfi -i color=size=640x480:rate=30 \
-vf  "drawtext=textfile='$TXT_FILE':x=5:y=5:fontfile=/usr/share/fonts/truetype/SpaceMono-Regular.ttf:fontsize=12:fontcolor=black:box=1:boxcolor=white" \
-t 10 $OUT  &>/dev/null

#ffmpeg \
#  -nostats  -hide_banner -loglevel panic \
#  -f lavfi -y -i color=size=640x480:rate=30 \
#  -vf "subtitles=$ASS_FILE"\
#  -t 10 $OUT  &>/dev/null
cat $OUT
rm $OUT
