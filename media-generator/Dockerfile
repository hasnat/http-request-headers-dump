FROM linuxserver/ffmpeg
#ADD https://github.com/jqlang/jq/releases/download/jq-1.6/jq-linux64 /usr/local/bin/jq
#RUN apt-get update && apt-get install -y imagemagick && apt-get clean
COPY --from=msoap/shell2http /app/shell2http /usr/local/bin/shell2http
COPY SpaceMono-Regular.ttf /usr/share/fonts/truetype/
WORKDIR /app
COPY run-gif.sh \
     run-m4a.sh \
     run-m4v.sh \
     run-jpg.sh \
     run.sh \
     /app/



# /gen?gen_text=Hello%20World


