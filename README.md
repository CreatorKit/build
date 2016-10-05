##  Creator-Kit Top level Build system

In order to build the IoT Kit projects, we need to collect source code from multiple repositories. The following process will bring these repositories together into a single build environment. The individual repositories used are from these Github organisations:

* CreatorKit
* CreatorDev
* FlowM2M
* Cascoda

### Building Creator Kit Projects

#### 1. Install repo tool

To pull together multiple repos, you will need to install the "repo" tool.

On Ubuntu 16.04:

    $ sudo apt-get install repo

On Ubuntu 14.04:

    $ mkdir -p ~/bin
    $ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    $ chmod a+x ~/bin/repo

Update ~/.bashrc to add repo path in linux path permanently:

    export PATH=$PATH:~/bin/

#### 2. Sync with the upstream repositories

Create a new directory to keep project repositories, and run the following commands within the directory:

    $ repo init -u https://github.com/CreatorKit/manifest.git
    $ repo sync

After repo sync is complete, the required repositories are cloned inside the project directory.

#### 3. Build Projects

After the sync is complete you will find a 'build' folder. This folder allows you to build OpenWrt, Contiki and IoT Kit Projects from one directory.

    $ cd build

#### 3a. Install Dependencies

Before building you need to install dependencies.

**OpenWrt build dependencies**

    $ sudo apt-get install libncurses5-dev libncursesw5-dev zlib1g-dev libssl-dev gawk subversion device-tree-compiler

**Contiki build dependencies**

For 64-bit Ubuntu, 32-bit runtime libraries must be installed before the XC32 compiler can be run:

    $ sudo apt-get install libc6:i386

Download and install the XC32 Linux compiler (v1.34) from [here](http://ww1.microchip.com/downloads/en/DeviceDoc/xc32-v1.34-full-install-linux-installer.run).

#### 3b. Build

All make commands need to be run within the build directory.

To build the IoT Kit projects, append the config file name to the make command:

    $ make P=creator-kit-1-cascoda.config

The resulting build will be in the build/output folder.

For cleaning linux based applications:

    $ make clean_openwrt

_Note :- This will also clean the feeds._

For cleaning Contiki based applications:

    $ make clean_contiki

Linux and Contiki based applications can be cleaned by:

    $ make clean

## Pre-defined configurations

We are maintaining different pre-defined configurations in "config" files for building different CreatorKit projects.

    creator-kit-1.config - CreatorKit project1 related config for CC2520 based platforms.
    creator-kit-2.config - CreatorKit project2 related config for CC2520 based platforms.
    creator-kit-3.config - CreatorKit project3 related config for CC2520 based platforms.
    creator-kit-1-cascoda.config - CreatorKit project1 related config for CA8210 based platforms.
    creator-kit-2-cascoda.config - CreatorKit project2 related config for CA8210 based platforms.
    creator-kit-3-cascoda.config - CreatorKit project3 related config for CA8210 based platforms.

## To build for TI CC2520 platform

_Note :- By default, CreatorKit project1 is built for Cascoda CA8210 platform if no config has been specified using P= option. Always assume your 6LoWPAN Clicker is a Cascoda CA8210 board, unless you have specifically been notified otherwise._

Contiki

    $ make contiki P=creator-kit-1.config

OpenWrt

    $ make openwrt P=creator-kit-1.config

Whole OpenWrt and Contiki based applications.

    $ make P=creator-kit-1.config

Rest of the build options remain same as mentioned above in this document.

## Contiki specific build options:

Contiki

    $ make contiki P=creator-kit-1-cascoda.config SER=1 CH=26 ID=0xabcd


Here SER means USE_SERIAL_PADS i.e. UART2 for serial console
You can pass channel number in CH and pan_id in ID option.
Default values of CH , ID, SER are 26, 0xabcd, 0 respectively.

----

## Contributing

We welcome all contributions to this project and we give credit where it's due. Anything from enhancing functionality to improving documentation and bug reporting - it's all good.

For more details about the Contributor's guidelines, refer to the [contributor guide](https://github.com/CreatorKit/creator-docs/blob/master/ContributorGuide.md).
