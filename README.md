##  Creator-Kit Top level Build system

Creator-Kit requires multiple repositories for building, which are scattered across two GitHub organizations namely FlowM2M and CreatorKit.

### Steps for building CreatorKit project are as follows :-
Create a directory to keep project repositories, and run following commands :-

    $ mkdir creatorkit
    $ cd creatorkit
    $ repo init -u https://github.com/CreatorKit/manifest.git -b dev
    $ repo sync

_Note :- repo is a tool which should be present on your system. If not then follow this :-_

    $ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    $ chmod a+x ~/bin/repo

Now required repositories are cloned inside the project directory creatorkit.

Enter into build repository and start building :-

    $ cd build

There are multiple options for building things :-

Linux based applications using OpenWrt can be built by :-

    $ make openwrt

OpenWrt binaries can be found at :-

	creatorkit/dist/openwrt/bin/pistachio/

Contiki based applications can be built by :-

    $ make contiki

Contiki based application binaries can be found at :-

	creatorkit/packages/button-sensor/lwm2m-client-button-sensor.hex
	creatorkit/packages/led-actuator/lwm2m-client-led-actuator.hex

Linux and Contiki based applications can be built by :-

    $ make

For cleaning linux based applications :-

    $ make clean_openwrt

_Note :- This will also clean the feeds._

For cleaning Contiki based applications :-

    $ make clean_contiki

Linux and Contiki based applications can be cleaned by :-

    $ make clean
