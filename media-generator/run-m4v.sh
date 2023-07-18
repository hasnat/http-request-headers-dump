#!/usr/bin/env bash
#set -e

OUT="$TEMP_DIR/output.m4v"

ffmpeg \
  -nostats  -hide_banner -loglevel panic \
-y -f lavfi -i color=size=640x480:rate=30 \
-vf  "drawtext=textfile='$TXT_FILE':x=5:y=5:fontfile=/usr/share/fonts/truetype/SpaceMono-Regular.ttf:fontsize=12:fontcolor=black:box=1:boxcolor=white" \
-t 10 $OUT  &>/dev/null

cat $OUT
rm $OUT
