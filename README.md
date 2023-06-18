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

$ $ curl -vvv http://127.0.0.1:8080



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
