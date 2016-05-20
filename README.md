##  Creator-Kit Top level Build system

Creator-Kit requires multiple repositories for building, which are scattered across two GitHub organizations namely FlowM2M and CreatorKit.

### Steps for building CreatorKit project are as follows :-
Create a directory to keep project repositories, and run following commands :-

    $ mkdir creatorkit
    $ cd creatorkit
    $ repo init -u https://github.com/CreatorKit/manifest.git
    $ repo sync

_Note :- repo is a tool which should be present on your system. If not then follow this :-_

    $ mkdir -p ~/bin
    $ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    $ chmod a+x ~/bin/repo

Update ~/.bashrc to add repo path in linux path permanently :-

    export PATH=$PATH:~/bin/

Now required repositories are cloned inside the project directory creatorkit.

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

For cleaning linux based applications :-

    $ make clean_openwrt

_Note :- This will also clean the feeds._

For cleaning Contiki based applications :-

    $ make clean_contiki

Linux and Contiki based applications can be cleaned by :-

    $ make clean
