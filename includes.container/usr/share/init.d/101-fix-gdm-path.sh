#!/bin/bash

if [ ! -f /var/init.lock.d/101-fix-gdm-path ]; then
  echo "Fixing GDM path permissions"
  chown -R Debian-gdm:Debian-gdm /var/lib/gdm3/
  chmod -R 751 /var/lib/gdm3/
  mkdir -p /var/init.lock.d/
  touch /var/init.lock.d/101-fix-gdm-path
else
  echo "GDM path fix already applied."
fi
