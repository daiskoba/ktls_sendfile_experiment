FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y build-essential git libpcre3-dev zlib1g-dev curl

RUN mkdir /work

RUN git clone --depth 1 https://github.com/openssl/openssl /work/openssl
WORKDIR /work/openssl
RUN ./Configure --libdir=lib/$(dpkg-architecture -qDEB_HOST_MULTIARCH) enable-ktls
RUN make -j
RUN make install_sw install_ssldirs
RUN ldconfig

RUN openssl req -new -newkey rsa:2048 -sha1 -x509 -nodes \
    -set_serial 1 \
    -days 365 \
    -subj "/C=JP/ST=Osaka/L=Osaka City/CN=example.com" \
    -out /work/example.com.crt \
    -keyout /work/example.com.key

RUN git clone --depth 1 https://github.com/nginx/nginx /work/nginx
WORKDIR /work/nginx
RUN ./auto/configure --with-openssl=/work/openssl --with-openssl-opt=enable-ktls \
    --with-http_ssl_module
RUN make -j
RUN make install

COPY nginx.conf /usr/local/nginx/conf/
COPY test_sslapi.sh run_s_server.sh /usr/local/bin/
WORKDIR /usr/local/nginx/html
RUN truncate -s 1g /usr/local/nginx/html/1G
RUN truncate -s 10m /usr/local/nginx/html/10M
EXPOSE 443
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
