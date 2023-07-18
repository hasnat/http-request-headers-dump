#!/usr/bin/env bash
#set -e


OUT="$TEMP_DIR/output.m4a"
say -o $OUT -f $TXT_FILE  &>/dev/null
cat $OUT
rm $OUT