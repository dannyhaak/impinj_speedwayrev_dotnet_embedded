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
  apt-get install -y mono-complete mono-devel # mono packages
  apt-get install -y libc6-dev-i386 g++-multilib # 32-bit compatibility for cap generator
  apt-get install -y lib32z1 # z-lib for cap generator

  # Install current mono from repositories
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
  sudo apt-get update
  sudo apt-get dist-upgrade -y

  # Create directories
  mkdir -p /home/vagrant/mono_build
  mkdir -p /home/vagrant/mono_source

  # Get the Mono source
  cd /home/vagrant/mono_source
  wget http://download.mono-project.com/sources/mono/mono-4.2.3.4.tar.bz2
  tar xvf mono-4.2.3.4.tar.bz2
  cd mono-*

  #apt-get source mono
  #cd mono*

  # Configure Mono
  ./configure --host=arm-linux-gnueabi --prefix=/home/vagrant/mono_build --disable-mcs-build

  # Build and install Mono
  make
  make install
fi
