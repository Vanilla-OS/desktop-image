#!/bin/sh

RUNS=""

for file in $(find bucket/install -name "*.inst"); do
    name=$(basename $file .inst)
    content=$(cat $file)
    pkgs=$(echo $content | sed "s/ / /g")
    RUNS="$RUNS\RUN apt-get install -y $pkgs\n"
done

sed "s/@@PKGS_INST@@/$RUNS/" Containerfile.tpl > Containerfile