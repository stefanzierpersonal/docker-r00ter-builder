#!/bin/bash
mkdir -p ~/rooter-builds
chown 1000:1000 ~/rooter-builds -R 
docker run --rm -v ~/rooter-builds:/home/user/rooter19076/images -it rooter_builder /bin/bash

