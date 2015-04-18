#!/usr/bin/env bash

# Disable errors 'unable to re-open stdin: No such file or directory'
export DEBIAN_FRONTEND=noninteractive

# Enable main and universe repositories
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe"

# Update packages to latest versions
apt-get update
apt-get upgrade -y

if [ ! -d "/home/vagrant/mono_build" ]; then
  # Install tooling
  apt-get install -y build-essential gettext # general build stuff
  apt-get install -y gcc-arm-linux-gnueabi # arm packages
  apt-get install -y mono-complete # mono packages
  apt-get install -y libc6-dev-i386 g++-multilib # 32-bit compatibility for cap generator
  apt-get install -y lib32z1 # z-lib for cap generator

  # Create directories
  mkdir -p /home/vagrant/mono_build
  mkdir -p /home/vagrant/mono_source

  # Get the Mono source
  cd /home/vagrant/mono_source
  apt-get source mono
  cd mono*

  # Configure Mono
  ./configure --host=arm-linux-gnueabi --prefix=/home/vagrant/mono_build --disable-mcs-build

  # Build and install Mono
  make
  make install
fi
