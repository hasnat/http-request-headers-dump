#!/usr/bin/env bash
#set -e


OUT="$(mktemp $OUTPUT_DIR/output.XXXXXXXXXX.m4a)"
say -o $OUT -f $TXT_FILE  &>/dev/null
cat $OUT
rm $OUT