FROM nginx:alpine
ENV HIDE_HEADERS
RUN echo -e '\n\
\n\
load_module /usr/lib/nginx/modules/ngx_http_js_module.so;\n\
env HIDE_HEADERS;\n\
events {\n  worker_connections  1024;\n}\n\
http {\n\
js_import /usr/local/njs_print_headers.js;\n\
  server {\n\
    listen 8080;\n\
    location / {\n\
      default_type text/plain;\n\
      js_content njs_print_headers;\n\
    }\n\
  }\n\
}' > /etc/nginx/nginx.conf 

RUN echo -e 'const skipHeaders = (process.env.HIDE_HEADERS || '').split(',').map(e => e.toLowerCase()) \n\
export default function njs_print_headers(r) {\n\
  r.headersOut["Content-Type"] = "text/plain";\n\
  var headers = "";\n\
  for (var header in r.headersIn) {\n\
    if (!skipHeaders.includes(header.toLowerCase())) \n\
    headers += header + ": " + r.headersIn[header] + "\\n\
";\n\
  }\n\
  r.return(200, headers);\n\
}' > /usr/local/njs_print_headers.js
