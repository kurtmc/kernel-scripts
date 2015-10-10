#!/bin/bash

# Get the user and address of server
ADDRESS=$1

# This puts the latest version into ./kernel-latest
git archive master | tar -x -C ./kernel-latest

# scp this to the server
scp -r ./kernel-lastest ${ADDRESS}:/tmp/

# then compile that shit
# then scp it back
# done
