#!/usr/bin/env bash
#set -e


OUT="$(mktemp $OUTPUT_DIR/output.XXXXXXXXXX.jpg)"

#convert -size 640x480 -background white -fill black -font /usr/share/fonts/truetype/SpaceMono-Regular.ttf -pointsize 12 label:"$GEN_TEXT" +repage -gravity west -extent 640x480 $OUT  &>/dev/null
ffmpeg \
  -nostats  -hide_banner -loglevel panic \
-y -f lavfi -i color=c=white:s=640x480 \
-vf  "drawtext=textfile='$TXT_FILE':x=5:y=5:fontfile=/usr/share/fonts/truetype/SpaceMono-Regular.ttf:fontsize=12:fontcolor=black:box=1:boxcolor=white" \
-frames:v 1 $OUT  &>/dev/null

#ffmpeg \
#  -nostats  -hide_banner -loglevel panic \
#  -f lavfi -y -i color=c=white:s=640x480 \
#  -vf "subtitles=$OUTPUT_DIR/typewriter.ass" \
#   $OUT  &>/dev/null
cat $OUT
rm $OUT
