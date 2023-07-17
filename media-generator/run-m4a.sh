#!/usr/bin/env bash
#set -e

#OUTPUT_DIR="$1"
#GEN_TEXT="$2"
#audio
OUT="$(mktemp $OUTPUT_DIR/output.XXXXXXXXXX.m4a)"
say -o $OUT -f $TXT_FILE  &>/dev/null
cat $OUT
rm $OUT