J?=1
DIR__BUILD:=$(PWD)
DIR__CKT:=$(DIR__BUILD)/..
DIR__OPENWRT:=$(DIR__BUILD)/../dist/openwrt
DIR__OPENWRT_FEEDS:=$(DIR__BUILD)/../dist/openwrt-feeds
DIR__OPENWRT_CKT_FEEDS:=$(DIR__BUILD)/../dist/openwrt-ckt-feeds
DIR__CONTIKI:=$(DIR__BUILD)/../constrained-os/contiki
all: openwrt contiki
	echo "All Done!"

contiki: build_contiki copy_contiki
	echo "Contiki Done!"

openwrt: build_openwrt copy_openwrt
	echo "OpenWrt Done!"

clean: clean_openwrt clean_feeds clean_contiki clean_binaries

# Building OpenWRT
.PHONY: openwrt/feeds.conf
openwrt/feeds.conf: $(DIR__OPENWRT)/feeds.conf

$(DIR__OPENWRT)/feeds.conf:
	cd $(DIR__OPENWRT); \
	cp $(DIR__BUILD)/feeds.conf .; \
	./scripts/feeds update -a; \
	./scripts/feeds install -a;
ifneq (_,_$(findstring all,$P))
	cd $(DIR__OPENWRT)/feeds/packages; patch -p1 < $(DIR__BUILD)/0001-glib2-make-libiconv-dependent-on-ICONV_FULL-variable.patch; \
	patch -p1 < $(DIR__BUILD)/0001-node-host-turn-off-verbose.patch;
endif

.PHONY: openwrt/.config
openwrt/.config: $(DIR__OPENWRT)/.config

$(DIR__OPENWRT)/.config: $(DIR__OPENWRT)/feeds.conf
	if test $(findstring P=,$(MAKEFLAGS)) && test -f $P; then \
		cat $P > $(DIR__OPENWRT)/.config; \
	else \
		cat creator-kit-1.config > $(DIR__OPENWRT)/.config; \
	fi
ifneq (_,_$(findstring all,$P))
	cp config-4.1-all $(DIR__OPENWRT)/target/linux/pistachio/config-4.1
endif
	$(MAKE) -C $(DIR__OPENWRT) defconfig

.PHONY: openwrt/version
openwrt/version: $(DIR__OPENWRT)/version

$(DIR__OPENWRT)/version:
	./getver.sh  $(DIR__OPENWRT) > $(DIR__OPENWRT)/version

.PHONY: build_openwrt
build_openwrt: openwrt/.config openwrt/version
ifneq (_,_$(findstring all,$P))
	$(MAKE) $(SUBMAKEFLAGS) -C $(DIR__OPENWRT) IGNORE_ERRORS=m -j$(J)
else
	$(MAKE) $(SUBMAKEFLAGS) -C $(DIR__OPENWRT) -j$(J)
endif

# Building Contiki apps
.PHONY: build_contiki
build_contiki:
ifneq (_,_$(findstring cascoda,$P))
	cd $(DIR__CONTIKI);git submodule init dev/ca8210;git submodule update
	$(MAKE) -C $(DIR__CKT)/packages/button-sensor TARGET=mikro-e USE_CA8210=1
else
	$(MAKE) -C $(DIR__CKT)/packages/button-sensor TARGET=mikro-e USE_CC2520=1
endif

# Copy files to build/output/
copy_contiki:
	mkdir -p $(DIR__BUILD)/output/contiki
	cp $(DIR__CKT)/packages/button-sensor/lwm2m-client-button-sensor.hex $(DIR__BUILD)/output/contiki/

copy_openwrt:
	mkdir -p $(DIR__BUILD)/output/openwrt/packages
	cp -rf $(DIR__OPENWRT)/bin/pistachio/packages/* $(DIR__BUILD)/output/openwrt/packages/
	cd $(DIR__BUILD)/output/openwrt/;tar -cvzf packages.tar.gz packages
	find $(DIR__OPENWRT)/bin/pistachio/ -maxdepth 1 -type f -exec cp {} $(DIR__BUILD)/output/openwrt/ \;

# Clean OpenWRT
# Deletes contents of the directories /bin and /build_dir
.PHONY: clean_openwrt
clean_openwrt:
	$(MAKE) -C $(DIR__OPENWRT) clean

# Clean Contiki
.PHONY: clean_contiki
clean_contiki:
	$(MAKE) -C $(DIR__CKT)/packages/button-sensor TARGET=mikro-e clean

.PHONY: clean_feeds
clean_feeds:
	cd $(DIR__OPENWRT); \
	rm -rf .config feeds.conf tmp/ feeds;

.PHONY: clean_binaries
clean_binaries:
	rm -rf $(DIR__BUILD)/output/
