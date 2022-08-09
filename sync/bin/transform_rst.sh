#!/bin/bash

find ../ -name "*.rst*" | while read i; do pandoc -f rst -t asciidoc "$i" -o "${i%.*}.adoc"; done
find ../ -name "*.rst" -type f -delete
