#!/usr/bin/env bash
# Script for generating gocc packages.

# All files generated by gocc are kept under tmp directory.
tmp="./tmp"
src="./src"

mkdir -p "$tmp"

if [ -z "$GOPATH" ]; then
    echo "GOPATH environment variable is not set"
    exit 1
else
    goccpath="$GOPATH"/bin/gocc
    if [ -f "$goccpath" ]; then
        "$goccpath" -a -zip -o "$tmp" "$src"/lang.bnf
        # The generated file is not correctly formatted by default.
        gofmt -w ./tmp/parser/productionstable.go
    else
        echo "gocc is not properly installed"
        exit 1
    fi
fi
