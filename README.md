# request-headers-dump

[Docker Hub Registry: hasnat/request-headers-dump](https://hub.docker.com/r/hasnat/request-headers-dump)

Dumps http client's request headers 

```

$ docker run -it -d \
  --name request-headers-dump \
  -p 8080:8080 \
  -e RESPONSE_HEADERS=$'Accept-CH: Sec-CH-UA-Model\nX-Real-Hero: You!'\
  -e HIDE_HEADERS=X-Real-IP,X-Forwarded-For,X-Forwarded-Proto,X-Forwarded-Ssl,X-Forwarded-Port \
  hasnat/request-headers-dump

$ curl -vvv http://127.0.0.1:8080



*   Trying 127.0.0.1:8080...
* Connected to 127.0.0.1 (127.0.0.1) port 8081 (#0)
> GET / HTTP/1.1                               <== request headers verbose
> Host: 127.0.0.1:8080
> User-Agent: curl/7.88.1
> Accept: */*
> 
< HTTP/1.1 200 OK                             <== response headers verbose
< Server: nginx/1.25.1
< Date: Sun, 18 Jun 2023 09:12:47 GMT
< Content-Type: text/plain
< Content-Length: 57
< Connection: keep-alive
< Accept-CH: Sec-CH-UA-Model                  <== RESPONSE_HEADERS
< X-Real-Hero: You!
< 
Host: 127.0.0.1:8080                          <== response body (client) headers
User-Agent: curl/7.88.1
Accept: */*
* Connection #0 to host 127.0.0.1 left intact


```

# dev-setup

```
                                                                                                         ┌────────────────────────────────────────────────────────────────────────┐
                                                                                                         │                                                                        │
                                                                                                         │                                                                        │
                                                                                                         │ request-headers-dump (main.js) # headers read/write & content servings │
                                                                                                      ┌─▶│            media-generator     # generate audio/video/image            │
                                                                                                      │  │                                                                        │
                                                                                                      │  │                                                                        │
                                                                                                      │  └────────────────────────────────────────────────────────────────────────┘
                                                                ╭─────────────────────────────────────┼────────────────────────╮                                                   
                                                                │ ◎ ○ ○ ░░░░░░░░░░░░░░░░░░░░dev-setup░│░░░░░░░░░░░░░░░░░░░░░░░░│                                                   
                                                                ├─────────────────────────────────────┼────────────────────────┤                                                   
                                                                │                                     │                        │                                                   
                                                                │                                     │    ╭──────────────╮    │       ┌──────────────────────────────────────────┐
                                                                │                   ╭──────────────╮  │    │ ◎ ○ ○ ░░░░░░░│    │       │                                          │
                                                                │                   │ ◎ ○ ○ ░░░░░░░│  │    ├──────────────┤    │       │                                          │
                                                                │                   ├──────────────┤  │    │              │    │       │          macos: server for say           │
                                                                │                   │              │  │    │  say server  │────┼┐      │~/Downloads/shell2http_1.16.0_darwin_arm64│
                                                                │                   │    IDE       │──┘    │              │    ││      │              /shell2http \               │
                                                                │  ╭──────────────╮ │              │       │              │    ││      │            -host=127.0.0.1 \             │
                                                                │  │ ◎ ○ ○ ░░░░░░░│ │              │       └──────────────┘    ││      │               -port=9099 \               │
                                                                │  ├──────────────┤ └──────────────┘                           │└─────▶│            -export-all-vars \            │
                                                                │  │              │                                            │       │               -no-index \                │
                                                              ┌─┼──│    logs      │                          ╭──────────────╮  │       │              -one-thread \               │
┌─────────────────────────────────────────────────────────┐   │ │  │              │ ╭──────────────╮         │ ◎ ○ ○ ░░░░░░░│  │       │                  -cgi \                  │
│                                                         │   │ │  │              │ │ ◎ ○ ○ ░░░░░░░│         ├──────────────┤  │       │  POST:/generate 'GEN_TYPE=m4a ./run.sh'  │
│                          logs:                          │   │ │  └──────────────┘ ├──────────────┤         │              │  │       │                                          │
│  > docker-compose up --build -d && docker-compose logs  │   │ │                   │              │         │ rebuild/curl │  │       │                                          │
│    (media-generator/README.md to enable ffmpeg logs)    │◀──┘ │            ┌──────│ web preview  │         │              │  │       │                                          │
│                                                         │     │            │      │              │         │              │  │       └──────────────────────────────────────────┘
│                                                         │     │            │      │              │         └──────────────┘  │                                                   
└─────────────────────────────────────────────────────────┘     │            │      └──────────────┘                 │         │                                                   
                                                                └────────────┼───────────────────────────────────────┼─────────┘                                                   
                                                                             │                                       │                                                             
            ┌─────────────────────────────────────────────────────────┐      │                                       └───┐                                                         
            │                                                         │      │                                           │                                                         
            │                                                         │      │                                           │                                                         
            │                        browser:                         │      │                                           ▼                                                         
            │                > http://localhost:8080/                 │◀─────┘              ┌─────────────────────────────────────────────────────────┐                            
            │                                                         │                     │                        terminal:                        │                            
            │                                                         │                     │               > docker-compose up --build               │                            
            └─────────────────────────────────────────────────────────┘                     │       > curl -vvv http://localhost:8080/image.jpg       │                            
                                                                                            │       > curl -vvv http://localhost:8080/image.gif       │                            
                                                                                            │       > curl -vvv http://localhost:8080/video.m4v       │                            
                                                                                            │       > curl -vvv http://localhost:8080/audio.m4a       │                            
                                                                                            └─────────────────────────────────────────────────────────┘                            
```

# preview
image preview thumbnail
![image](https://raw.githubusercontent.com/hasnat/request-headers-dump/media-dump/Screenshot 2023-07-18 at 10.44.37 p.m..png)


