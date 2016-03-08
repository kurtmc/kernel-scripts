#!/bin/bash

if [ ! -f $(dirname $0)/config.sh ]; then
	echo "You must add a config.sh file"
	exit 1
fi

source $(dirname $0)/config.sh

pre-compile

make -j8
make modules

post-compile
