#!/bin/bash
# rmdir_empty.sh
# Remove empty directories recursively

find . -type d -not -path "./.git/*" -exec bash -c 'cd "{}" && rmdir "$PWD"' \;
