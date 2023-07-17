#!/usr/bin/env bash
#set -exou pipefail
# ^ for debugging
GEN_TEXT="$(</dev/stdin)"
OUTPUT_DIR=./outputs
mkdir -p $OUTPUT_DIR


TXT_FILE="$(mktemp $OUTPUT_DIR/output.XXXXXXXXXX.txt)"
echo "$GEN_TEXT" > $TXT_FILE
case "$GEN_TYPE" in

  m4a)

    TXT_FILE="$TXT_FILE" OUTPUT_DIR="$OUTPUT_DIR" ./run-m4a.sh

    ;;

  gif | m4v | jpg)

    echo "$GEN_TEXT" | fold -w 90  > "$TXT_FILE"


    TXT_FILE="$TXT_FILE" OUTPUT_DIR="$OUTPUT_DIR" ./run-$GEN_TYPE.sh

    ;;


  *)
    echo -n "unknown"
    ;;
esac
rm $TXT_FILE