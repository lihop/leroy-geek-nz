#!/bin/sh

elm-package install -y

mkdir -p ./static
for page in ./src/pages/*.elm; do
    filename="${page##*/}"
    elm-make "${page}" --output "static/${filename%.elm}.html"
done

stack install
