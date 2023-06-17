FROM nginx:alpine
ENV HIDE_HEADERS=""
ENV RESPONSE_HEADERS=""
RUN echo -e '\n\
\n\
load_module /usr/lib/nginx/modules/ngx_http_js_module.so;\n\
env HIDE_HEADERS;\n\
events {\n  worker_connections  1024;\n}\n\
http {\n\
js_import headers_dump from /usr/local/headers_dump.js;\n\
  server {\n\
    listen 8080;\n\
    location /favicon.ico {\n\
      add_header "Content-Type" "image/gif";\n\
      js_content headers_dump.fav_icon;\n\
    }\n\
    location / {\n\
      default_type text/plain;\n\
      js_content headers_dump.njs_print_headers;\n\
    }\n\
  }\n\
}' > /etc/nginx/nginx.conf 

RUN echo -e '\n\
\n\
const hide_headers = (process.env.HIDE_HEADERS || "").split(",").map(e => e.toLowerCase()) \n\
var headers_out = "";
try { (process.env.RESPONSE_HEADERS || "").split("\\n").map(e => {var hdr = e.split(":"); return [[hdr[0]],hdr[1].trim()])} catch(e){} \n\
export default {njs_print_headers,fav_icon};\n\
var fav_icon_bytes = Buffer.from("AAABAAEAEBAQAAEABAAoAQAAFgAAACgAAAAQAAAAIAAAAAEABAAAAAAAgAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAXZkAAPPz8wCeDgkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMzMzMzAAADIiIiIiMAAAMhEhERIwAAAyIiIiIjAAADIRIRESMAAAMiIiIiIwAAAyESEREjAAADIiIiIiMAAAMhEhERIwAAAyIiIiIjAAADIRIRESMAAAMiIiIzMwAAAyESETIwAAADIiIiMwAAAAMzMzMwAAD//wAA4AMAAOADAADgAwAA4AMAAOADAADgAwAA4AMAAOADAADgAwAA4AMAAOADAADgAwAA4AcAAOAPAADgHwAA", "base64");\n\
function fav_icon(r) {\n\
  return r.return(200, fav_icon_bytes);\n\
}\n\
function njs_print_headers(r) {\n\
  headers_out.map(h => {r.headersOut[h[0]] = h[1];})
  r.headersOut["Content-Type"] = "text/plain";\n\
  var headers = "";\n\
  for (var header in r.headersIn) {\n\
    if (!hide_headers.length || !hide_headers.includes(header.toLowerCase())) { \n\
      headers += header + ": " + r.headersIn[header] + "\\n";\n\
    }\n\
  }\n\
  r.return(200, headers);\n\
}' > /usr/local/headers_dump.js
