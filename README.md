##  Creator-Kit Top level Build system

Creator-Kit requires multiple repositories for building, which are scattered across two GitHub organizations namely FlowM2M and CreatorKit.

### Steps for building CreatorKit project are as follows :-
Create a directory where you want to keep your project repositories, and run following commands :-

    mkdir my_creatorkit
    cd my_creatorkit
    repo init -u https://github.com/CreatorKit/manifest.git -b branch-name
    repo sync

_Note :- repo is a tool which should be present on your system. If not then follow this :-_

    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo

Now you have all the required repositories cloned inside you project directory my_creatorkit.

Enter into build repository and start building :-

    cd build

There are multiple options for building things :-

You could just build linux based applications using OpenWrt :-

    make openwrt

You could just build Contiki based applications :-

    make contiki

Or you could build both :-

    make

To clean and rebuild just linux based applications using OpenWrt :-

    make clean_openwrt
    make openwrt

_Note :- This will also clean the feeds._

For cleaning contiki based applications:-

    make clean_contiki

And there is one command to clean everything :-

    make clean
