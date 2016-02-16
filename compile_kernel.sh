#!/bin/bash

source config.sh

pre-compile

make -j8
make modules

post-compile
