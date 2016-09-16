##  Creator-Kit Top level Build system

Creator-Kit requires multiple repositories for building, which are scattered across two GitHub organizations namely CreatorKit, Creatordev, FlowM2M and Cascoda.

### Steps for building CreatorKit projects are as follows :-

Create a directory to keep project repositories, and run following commands :-

    $ mkdir creatorkit
    $ cd creatorkit
    $ repo init -u https://github.com/CreatorKit/manifest.git -b dev
    $ repo sync

_Note :- repo is a tool which should be present on your system. If not then follow this :-_

    $ mkdir -p ~/bin
    $ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    $ chmod a+x ~/bin/repo

Update ~/.bashrc to add repo path in linux path permanently :-

    export PATH=$PATH:~/bin/

After repo sync is complete, required repositories are cloned inside the project directory creatorkit.

Enter into build repository and start building :-

    $ cd build

There are multiple options for building things :-

Linux based applications using OpenWrt can be built by :-

    $ make openwrt

OpenWrt binaries can be found at :-

    creatorkit/build/output/openwrt/

Contiki based applications can be built by :-

    $ make contiki

Contiki based application binaries can be found at :-

    creatorkit/build/output/contiki/

Linux and Contiki based applications can be built by :-

    $ make

Additional arguments could also be passed while building OpenWrt for logging more information, or building it in parallel threads. e.g.

1. For logging all information

        $ make openwrt V=s

2. For logging just errors/warnings

        $ make openwrt V=w

3. For building OpenWrt in parallel threads

        $ make openwrt J=20

4. For building OpenWrt's different projects, different configs needs to be passed.

        $ make openwrt P=creator-kit-1-cascoda.config

For cleaning linux based applications :-

    $ make clean_openwrt

_Note :- This will also clean the feeds._

For cleaning Contiki based applications :-

    $ make clean_contiki

Linux and Contiki based applications can be cleaned by :-

    $ make clean

## Pre-defined configurations:

We are maintaining different pre-defined configurations in "config" files for building different CreatorKit projects.

    creator-kit-1.config - CreatorKit project1 related config for CC2520 based platforms.
    creator-kit-2.config - CreatorKit project2 related config for CC2520 based platforms.
    creator-kit-3.config - CreatorKit project3 related config for CC2520 based platforms.
    creator-kit-1-cascoda.config - CreatorKit project1 related config for CA8210 based platforms.
    creator-kit-2-cascoda.config - CreatorKit project2 related config for CA8210 based platforms.
    creator-kit-3-cascoda.config - CreatorKit project3 related config for CA8210 based platforms.

## To build for Cascoda CA8210 platform:

_Note :- By default, CreatorKit project1 is built for Cascoda CA8210 platform if no config has been specified using P= option._

Contiki

    $ make contiki P=creator-kit-1-cascoda.config

OpenWrt

    $ make openwrt P=creator-kit-1-cascoda.config

Whole OpenWrt and Contiki based applications.

    $ make P=creator-kit-1-cascoda.config

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

