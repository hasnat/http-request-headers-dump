var fs = require('fs')
const hide_headers = []||(process.env.HIDE_HEADERS || "").split(",").map(h => h.toLowerCase())
var headers_out = []||(process.env.RESPONSE_HEADERS || "").split("\\n").map(h => {
 try { var hdr = h.split(":"); return [hdr[0].trim(),hdr[1].trim()]; } catch(e){}
});

function log_request(r) {

  return (JSON.stringify({
    time_local: r.variables.time_local,
    scheme: r.variables.scheme,
    method: r.variables.method,
    status: r.variables.status,
    request_uri: r.variables.request_uri,
    request_length: r.variables.request_length,
    request_time: r.variables.request_time,
    bytes_sent: r.variables.bytes_sent,
    body_bytes_sent: r.variables.body_bytes_sent,
    upstream_addr: r.variables.upstream_addr,
    upstream_status: r.variables.upstream_status,
    upstream_response_time: r.variables.upstream_response_time,
    upstream_connect_time: r.variables.upstream_connect_time,
    upstream_header_time: r.variables.upstream_header_time,
    remote_addr: r.variables.remote_addr,
    remote_user: r.variables.remote_user,
    headers: r.headersIn
  }));
}
function main_html(headers) {
  return `
    <html>
        <head>
        <title>Headers Dump</title>
        </head>
        <body>
            <h1>Request Headers</h1>
            <pre style="white-space: pre-line; border: 1px solid gray;">${headers}</pre>
            <img width="320" height="240" alt="${headers}" src="/image.gif" />
            <img width="320" height="240" alt="${headers}" src="/image.jpg" />
            <video width="320" height="240" controls>
                <source src="/video.m4v" >
            </video>
            <audio controls>
                <source src="/audio.m4a" >
            </audio>
            <pre id="script" style="white-space: pre-line; border: 1px solid teal;"></pre>
            <pre id="ajax" style="white-space: pre-line; border: 1px solid orange;"></pre>
            <pre id="fetch" style="white-space: pre-line; border: 1px solid blue;"></pre>
            <script src="/script.js"></script>
            <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Call the function to make the AJAX request once the document is loaded
            makeAjaxRequest();
            makeFetchRequest();
        });

        function makeAjaxRequest() {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', '/ajax', true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        var response = xhr.responseText;
                        document.getElementById('ajax').textContent = response;
                    } else {
                        document.getElementById('ajax').textContent = 'Error: ' + xhr.status + JSON.stringify(xhr);
                    }
                }
            };
            xhr.onerror = function() {
                document.getElementById('ajax').textContent = 'Network Error';
            };
            xhr.send();
        }
        function makeFetchRequest() {
            fetch('/ajax')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.text();
                })
                .then(data => {
                    document.getElementById('fetch').textContent = data;
                })
                .catch(error => {
                    document.getElementById('fetch').textContent = 'Error: ' + error.message;
                });
        }
    </script>
        </body>
    </html>
  `
}
function get_headers_as_text(headersIn) {
  var headers = "";
  for (var header in headersIn) {
    if (!hide_headers.length || !hide_headers.includes(header.toLowerCase())) {
      headers += `${header}: ${headersIn[header]}\n`;
    }
  }
  return headers;
}

async function homepage(r) {
  headers_out.map(h => {r.headersOut[h[0]] = h[1];}) 
  r.headersOut["Content-Type"] = "text/html";
  var headers = get_headers_as_text(r.headersIn);
  r.return(200, main_html(headers));
}

async function ajax(r) {
  headers_out.map(h => {r.headersOut[h[0]] = h[1];})
  r.headersOut["Content-Type"] = "text/plain";
  var headers = get_headers_as_text(r.headersIn);
  r.return(200, headers);
}
async function script_js(r) {
  headers_out.map(h => {r.headersOut[h[0]] = h[1];})
  r.headersOut["Content-Type"] = "text/javascript";
  var headers = get_headers_as_text(r.headersIn);
  r.return(200, `document.getElementById('script').textContent = \`${headers}\`;`);
}
async function audio_m4a(r) {
  await process_sub_request("m4a",r);
}
async function video_m4v(r) {
  await process_sub_request("m4v",r);
}
async function image_gif(r) {
  await process_sub_request("gif",r);
}
async function image_jpg(r) {
  await process_sub_request("jpg",r);
}
const process_sub_request_conf = {
  m4a: {
//  cd media-generator
//  ~/Downloads/shell2http_1.16.0_darwin_arm64/shell2http -host=127.0.0.1  -port=9099 -export-all-vars -no-index -one-thread -cgi POST:/generate 'GEN_TYPE=m4a ./run.sh'
    url: "http://host.docker.internal:9099/generate",
    "Content-Type": "audio/m4a"
  },
  m4v: {
    url: "http://media-generator:8080/generate-m4v",
    "Content-Type": "video/m4v"
  },
  gif: {
    url: "http://media-generator:8080/generate-gif",
    "Content-Type": "image/gif"
  },
  jpg: {
    url: "http://media-generator:8080/generate-jpg",
    "Content-Type": "image/jpg"
  }
}
async function process_sub_request(type, r) {
  headers_out.map(h => {r.headersOut[h[0]] = h[1];})
  try {
    var headers = get_headers_as_text(r.headersIn);
    var p_response = await ngx.fetch(
        process_sub_request_conf[type].url
        ,{
          detached: false,
          method: "POST",
          body: headers
        }
    );
    let p_response_body = await p_response.text();
    r.headersOut["Content-Type"] = process_sub_request_conf[type]["Content-Type"];
    r.return(200, p_response_body);
  } catch (e) {
    r.return(500, e);
    r.error('Err')
    r.error(e)
  }
}



export default {homepage,script_js,audio_m4a,image_gif,image_jpg,video_m4v,log_request,ajax};