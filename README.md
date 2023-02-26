# request-headers-dump

[Docker Hub Registry: hasnat/request-headers-dump](https://hub.docker.com/r/hasnat/request-headers-dump)

Dumps request headers 

```

$ docker run -it -d \
  --name request-headers-dump \
  -e HIDE_HEADERS=X-Real-IP,X-Forwarded-For,X-Forwarded-Proto,X-Forwarded-Ssl,X-Forwarded-Port \
  hasnat/request-headers-dump

$ curl http://127.0.0.1:8080

Host: 127.0.0.1:8080
User-Agent: curl/7.86.0
Accept: */*
```
