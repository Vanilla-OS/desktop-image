#!/bin/bash

PACKAGES=/usr/share/abroot/package-summary
if [ -s "$PACKAGES" ]; then
    echo "image not clean due to abroot pkg, skipping FSGuard"
    exit 0
fi

function failed() {
    /.system/usr/bin/plymouth quit
    local squashfs="/.system/boot/fswarn.squash"
    mount -t tmpfs -o rw,size=1G tmpfs /tmp
    local tmp="/tmp"
    chmod 0755 "$tmp"
    unsquashfs -q -L -follow -d /tmp "$squashfs"
    mount --rbind /dev "$tmp/dev"

    local resolution=$(chroot "$tmp" /bin/bash -c '/usr/sbin/fbset | /bin/grep "mode " | /bin/sed "s/\"//g" | /bin/sed "s/-0//g" | /usr/bin/gawk '\''BEGIN{FS=" "}; {print $2}'\''')
    clear
    tput cnorm
    echo -e "\033[1;0H"
    chroot "$tmp" /bin/bash -c "convert -resize $resolution -background black -gravity center -extent $resolution /verification_failed.png bgra:/dev/fb0"
    echo -e "\033[999;0H"
    read -sn1 input
    if [[ "$input" == "c" ]]; then
        echo -e "\033[1;0H"
        chroot "$tmp" /bin/bash -c "convert -resize $resolution -background black -gravity center -extent $resolution /continue_confirm.png bgra:/dev/fb0"
        echo -e "\033[999;0H"
        read -sn1 input
        if [[ "$input" == "y" ]]; then
            return
        else
            poweroff -f
        fi
    else
        poweroff -f
    fi
}

/usr/sbin/FsGuard verify "/.system/FsGuard/filelist"
if [[ $? -ne 0 ]]; then
    failed
fi
