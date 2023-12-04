#!/bin/bash

if ! command -v md2pdf &> /dev/null
then
    echo "md-to-pdf is not installed. Installing..."
    npm install -g md-to-pdf
fi

md2pdf dokumentacio.md

