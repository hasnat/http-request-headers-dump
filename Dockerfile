FROM nginx:alpine
ENV HIDE_HEADERS=""
ENV RESPONSE_HEADERS=""

COPY nginx.conf /etc/nginx/
COPY main.js favicon.ico /usr/local/
