#!/usr/bin/env bash
#set -e


OUT="$(mktemp $OUTPUT_DIR/output.XXXXXXXXXX.jpg)"

ffmpeg \
  -nostats  -hide_banner -loglevel panic \
-y -f lavfi -i color=c=white:s=640x480 \
-vf  "drawtext=textfile='$TXT_FILE':x=5:y=5:fontfile=/usr/share/fonts/truetype/SpaceMono-Regular.ttf:fontsize=12:fontcolor=black:box=1:boxcolor=white" \
-frames:v 1 $OUT  &>/dev/null

cat $OUT
rm $OUT
