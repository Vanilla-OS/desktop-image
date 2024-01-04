#!/bin/sh

packages=""
IFS='
'
for line in $(dpkg -l --no-pager); do
    case "$line" in
        "ii"*)
            items=$(echo "$line" | sed -E "s/\\s+/ /g")
            name=$(echo "$items" | cut -d ' ' -f2 | cut -d ':' -f1)
            version=$(echo "$items" | cut -d ' ' -f3)
            packages="$packages{\"name\":\"$name\",\"version\":\"$version\"},"
            ;;
    esac
done

packages="[${packages%,}]"
printf "\"packages\":%s\n" "$packages"
