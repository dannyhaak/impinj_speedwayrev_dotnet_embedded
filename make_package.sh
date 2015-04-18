#!/usr/bin/env bash

echo "+ Asked to create Impinj Speedway package from $1/$2"

echo "+ Booting virtual machine"
vagrant up

echo "+ Starting script on guest"
vagrant ssh -c "/vagrant/scripts/make_package_guest.sh $1 $2"

echo "+ Done; now upload the packages via the web interface"
