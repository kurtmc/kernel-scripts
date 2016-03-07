#!/bin/bash

if [ ! -f config.sh ]; then
	echo "You must add a config.sh file"
	exit 1
fi

source config.sh

pre-compile

make -j8
make modules

post-compile
