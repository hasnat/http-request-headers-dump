#!/usr/bin/env bash
#set -exou pipefail
# ^ for debugging
GEN_TEXT="$(</dev/stdin)"



TEMP_DIR="$(mktemp -d)"
TXT_FILE="$TEMP_DIR/TXT_FILE.txt"
echo "$GEN_TEXT" > $TXT_FILE
case "$GEN_TYPE" in

  m4a)

    TEMP_DIR="$TEMP_DIR" TXT_FILE="$TXT_FILE" ./run-m4a.sh

    ;;

  gif | m4v | jpg)

    echo "$GEN_TEXT" | fold -w 90  > "$TXT_FILE"


    TEMP_DIR="$TEMP_DIR" TXT_FILE="$TXT_FILE" ./run-$GEN_TYPE.sh

    ;;


  *)
    echo -n "unknown"
    ;;
esac
rm -r $TEMP_DIR