#!/bin/bash

# Script adapted from http://stackoverflow.com/questions/30180064/how-to-setup-youcompleteme-for-kernel-and-device-driver-development

ARCH=x86_64

list_sources() {
    echo "---> Listing sources..."

    find .                                   \
        -path "./arch*" -prune -o            \
        -path "./tmp*" -prune -o             \
        -path "./Documentation*" -prune -o   \
        -path "./scripts*" -prune -o         \
        -type f -name "*.[chsS]" -print >cscope.files

    find arch/$ARCH/include/                   \
        arch/$ARCH/kernel/                     \
        arch/$ARCH/common/                     \
        arch/$ARCH/boot/                       \
        arch/$ARCH/lib/                        \
        arch/$ARCH/mm/                         \
        arch/$ARCH/mach-omap2/                 \
        arch/$ARCH/plat-omap/                  \
        -type f -name "*.[chsS]" -print >>cscope.files
}

create_cscope_db() {
    echo "---> Creating cscope DB..."
    cscope -k -b -q
}

create_ctags_db() {
    echo "---> Creating CTags DB..."
    ctags -L cscope.files
}

cleanup() {
    echo "---> Removing garbage..."
    rm -f cscope.files
}

list_sources
create_cscope_db
create_ctags_db
cleanup
