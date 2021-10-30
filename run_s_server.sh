#!/bin/bash
cd /usr/local/nginx/html
openssl s_server -WWW -cert /work/example.com.crt -key /work/example.com.key -accept 443 -ktls -sendfile
