README.md

# media-generator

Text to video/audio/image generator

# debugging

For debugging 
1. use set -e in scripts
2. not use -nostats  -hide_banner -loglevel panic in ffmpeg commands
3. not use >/dev/null 2>&1 in ffmpeg commands
4. vist by curl -vvv http://localhost:8080/image.jpg 