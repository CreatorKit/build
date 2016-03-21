# Build Creator Kit Project

Creator-Kit requires multiple repositories for building, which are scattered across two GitHub organizations namely FlowM2M and CreatorKit.

Steps for building CreatorKit project are as follows:
- Create a directory where you want to keep your project repositories, and run following commands:
```
mkdir my_creatorkit
cd my_creatorkit
repo init -u https://github.com/CreatorKit/manifest.git -b branch-name
repo sync
```
**NOTE:** repo is a tool which should be present on your system. If not then follow this:
```
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
```
Also you should be having your GitHub userid and password saved in ~/.netrc to avoid typing them again and again, in the following format:
```
machine github.com login <your_userid> password <your_password>
```
- Now you have all the required repositories cloned inside you project directory my_creatorkit. Enter into build repository and start building:
```
cd build
```
Now you have multiple options for building things:

(i) You could just build OpenWRT:
```
make openwrt
```
(ii) You could just build Contiki:
```
make contiki
```
(iii) Or you could build both:
```
make
```
**NOTE:** OpenWRT downloads some packages from artifact server. Hence it would be better to keep its credentials too in ~/.netrc as:
```
machine imgsysart01.hh.imgtec.org login <your_userid> password <your_password>
```

#### Clean build
Different options for cleaning build repositories are as follows:
- Clean OpenWRT
```
make clean_openwrt
```
**NOTE:** This will also clean the feeds.
- Clean contiki
```
make clean_contiki
```
- Clean everything
```
make clean
```
