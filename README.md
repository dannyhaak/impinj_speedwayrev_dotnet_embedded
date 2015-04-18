# Introduction
The Impinj Speedway Revolution is a RAIN RFID (UHF) reader. It allows you to run embedded applications. So far, due to limited hardware capabilities, it only runned C or C++ applications. The new hardware revision (available as of spring 2015) has more flash, thus allows running C# embedded applications, using the Mono framework - making it significantly easier to create those applications.

Those scripts cross-compile Mono for the ARM processor in the reader, make a static binary and create a package that can be uploaded directly via the webinterface of the reader. It uses Vagrant (https://www.vagrantup.com) to set up the Linux environment that creates the build.

# To get started
- Install Vagrant (https://www.vagrantup.com)
- Add all .NET binaries (.exe and .dll) to a subdirectory of the Vagrant shared directory
- Execute ./make_package.sh <directory> <file.exe> (where <directory> is the subdirectory where the files are located, and <file.exe> is the primary executable)

Example:
```bash
./make_package.sh binaries HelloWorld.exe
```
creates a package where the executable binaries/HelloWorld.exe and all .dll files in this directory are included.

The first run can be rather slow, as it compiles Mono - but this is only a one-time operation.
