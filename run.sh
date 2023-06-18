#!/usr/bin/env bash
set -e

SPEEDS="1 3 5"
GEN_TEXT="$1"
mkdir -p outputs
# video / gif
#cat typewriter.ass.tpl > typewriter.ass && \
echo -e -n "[Script Info]\n; Comment with \";\"\n; Text will be appended to this template for video/gif generation\nScriptType: v4.00+\n\n[V4+ Styles]\nFormat: Name,  Fontname,  Fontsize,  PrimaryColour,  SecondaryColour,  OutlineColour,  BackColour,  Bold,  Italic,  Underline,  StrikeOut,  ScaleX,  ScaleY,  Spacing,  Angle,  BorderStyle,  Outline,  Shadow,  Alignment,  MarginL,  MarginR,  MarginV,  Encoding\nStyle: style1,  Arial,  30,  &H00FFFFFF, &HFF0000FF, &HFF000000, &H00000000, 0, 0, 0, 0, 100, 100, 0, 0, 1, 0, 0, 7, 20, 20, 20, 1\n\n\n[Events]\nFormat: Layer,  Start,  End,  Style,  Name,  MarginL,  MarginR,  MarginV,  Effect,  Text\nDialogue: 0, 0:00:00.5, 0:00:12.00, style1, , 0, 0, 0, , " > ./outputs/typewriter.ass && \
echo - -n && \
echo -n "$GEN_TEXT" \
  | sed 's/./&\n/g' \
  | while read p; do r=$(seq $SPEEDS| shuf | head -1); echo {\\k$r}$p; done \
  | tr -d '\n' \
  | sed 's/}{/} {/g' >> ./outputs/typewriter.ass && \
echo {\\k2000}± >> ./outputs/typewriter.ass

docker run --rm -it \
  -w /var/outputs \
  -v $(pwd)/outputs:/var/outputs \
  linuxserver/ffmpeg \
  -f lavfi -i color=size=640x480:rate=30 \
  -vf "subtitles=typewriter.ass" -t 8 oputput.mp4

docker run --rm -it \
  -w /var/outputs \
  -v $(pwd)/outputs:/var/outputs \
  linuxserver/ffmpeg \
  -f lavfi -i color=size=640x480:rate=30 \
  -vf "subtitles=typewriter.ass" -t 8 oputput.gif


#audio
say -o ./outputs/oputput.m4a -f <(echo $GEN_TEXT)

