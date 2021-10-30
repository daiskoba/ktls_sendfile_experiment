#!/bin/bash
cd /work/openssl
make tests TESTS=test_sslapi V=1
