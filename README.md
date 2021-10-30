ktls_sendfile_experiment
========================

I wrote a blog at [Linuxのkernel TLSでnginxのSSL_sendfileを試してみた · hnakamur's blog](https://hnakamur.github.io/blog/2021/10/31/tried-linux-kernel-tls-nginx-sendfile/).

## Build docker image

```
docker build -t ktls_sendfile .
```

## Run OpenSSL ktls_sendfile test

```
docker run --rm -it ktls_sendfile test_sslapi.sh
```

## Test ktls_sendfile with OpenSSL s_server

Run the server.

```
docker run --rm -it ktls_sendfile run_s_server.sh
```

Run curl.

```
docker exec -it $(docker ps -q) curl -sSkv -o /dev/null https://localhost/index.html
```

## Test ktls_sendfile with nginx

Run nginx.

```
docker run --rm -it ktls_sendfile
```

Run curl.

```
docker exec -it $(docker ps -q) curl -sSkv -o /dev/null https://localhost
```
