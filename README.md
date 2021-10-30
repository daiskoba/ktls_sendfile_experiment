ktls_sendfile_experiment
========================

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
