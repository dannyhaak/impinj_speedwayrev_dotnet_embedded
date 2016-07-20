#!/usr/bin/env bash

echo "++ Checking whether $1/$2 exists"
cd /vagrant/

if [ ! -d "$1" ]; then
    echo "[ERROR] Directory $1 not found"
    exit 0
fi

cd $1

if [ ! -f "$2" ]; then
    echo "[ERROR] File $1/$2 not found"
    exit 0
fi

echo "++ Setting environmental variables"
export CC="arm-linux-gnueabi-gcc"
export AS="arm-linux-gnueabi-as"
export PKG_CONFIG_PATH="/home/vagrant/mono_build/lib/pkgconfig"

echo "++ Preparing directories"
if [ -d "/vagrant/tmp" ]; then
    rm -rf /vagrant/tmp
fi
mkdir -p /vagrant/tmp

if [ -d "/vagrant/cap" ]; then
    rm -rf /vagrant/cap
fi
mkdir -p /vagrant/cap
mkdir -p /vagrant/cap/sys

if [ -d "/vagrant/output" ]; then
    rm -rf /vagrant/output
fi
mkdir -p /vagrant/output

echo "++ Making a static executable"

mkbundle --static --machine-config /etc/mono/4.5/machine.config --deps --config /vagrant/support/config $2 *.dll -o /vagrant/tmp/app

echo "++ Strip the static executable"
arm-linux-gnueabi-strip /vagrant/tmp/app

echo "++ Create CAP package to install on Speedway"
cp /vagrant/tmp/app /vagrant/cap/app
cp /vagrant/includes/* /vagrant/cap

# create develop package, which enables shell access and FTP
cd /vagrant/scripts/
cp /vagrant/support/reader.conf_develop /vagrant/cap/sys/reader.conf
./cap_gen -d /vagrant/support/cap_description.in -o ../output/app_develop.upg

# create release package
cp /vagrant/support/reader.conf_release /vagrant/cap/sys/reader.conf
./cap_gen -d /vagrant/support/cap_description.in -o ../output/app_release.upg

echo "++ Cleaning up"
rm -rf /vagrant/cap
rm -rf /vagrant/tmp

echo "++ Output files created in directory output/"
