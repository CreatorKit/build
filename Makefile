J?=1
CH?=26
ID?=0xabcd
SER?=0
DIR__BUILD:=$(PWD)
DIR__CKT:=$(DIR__BUILD)/..
DIR__OPENWRT:=$(DIR__BUILD)/../dist/openwrt
DIR__CONTIKI:=$(DIR__BUILD)/../constrained-os/contiki
all: openwrt contiki
	echo "All Done!"

contiki: build_contiki copy_contiki
	echo "Contiki Done!"

openwrt: build_openwrt copy_openwrt
	echo "OpenWrt Done!"

clean: clean_openwrt clean_feeds clean_contiki clean_binaries

# Building OpenWRT
$(DIR__OPENWRT)/feeds.conf:
	cd $(DIR__OPENWRT); \
	cp $(DIR__BUILD)/feeds.conf .; \
	./scripts/feeds update -a; \
	./scripts/feeds install -a;

$(DIR__OPENWRT)/.config: $(DIR__OPENWRT)/feeds.conf
	if test $(findstring P=,$(MAKEFLAGS)) && test -f $P; then \
		cat $P > $(DIR__OPENWRT)/.config; \
	else \
		cat creator-kit-1-cascoda.config > $(DIR__OPENWRT)/.config; \
	fi
	$(MAKE) -C $(DIR__OPENWRT) defconfig

$(DIR__OPENWRT)/version:
	./getver.sh  $(DIR__OPENWRT) > $(DIR__OPENWRT)/version

.PHONY: build_openwrt
build_openwrt: $(DIR__OPENWRT)/.config $(DIR__OPENWRT)/version
	$(MAKE) $(SUBMAKEFLAGS) -C $(DIR__OPENWRT) -j$(J)

get_kit_app:
	@$(eval KIT_APP_NO=$(shell echo $P | tr -cd [:digit:]))

# Building Contiki apps
.PHONY: build_contiki
build_contiki: get_kit_app
ifneq (_,_$(findstring cascoda,$P))
	@cd $(DIR__CONTIKI);git submodule init dev/ca8210;git submodule update
	@if [ $(KIT_APP_NO) -eq "1" ]; then $(MAKE) -C $(DIR__CKT)/packages/button-sensor TARGET=mikro-e USE_CA8210=1 USE_SERIAL_PADS=$(SER) CHANNEL=$(CH) PAN_ID=$(ID); fi
	@if [ $(KIT_APP_NO) -eq "2" ]; then $(MAKE) -C $(DIR__CKT)/packages/motion-sensor TARGET=mikro-e USE_CA8210=1 USE_SERIAL_PADS=$(SER) CHANNEL=$(CH) PAN_ID=$(ID); fi
else
	@if [ $(KIT_APP_NO) -eq "1" ]; then $(MAKE) -C $(DIR__CKT)/packages/button-sensor TARGET=mikro-e USE_CC2520=1 USE_SERIAL_PADS=$(SER) CHANNEL=$(CH) PAN_ID=$(ID); fi
	@if [ $(KIT_APP_NO) -eq "2" ]; then $(MAKE) -C $(DIR__CKT)/packages/motion-sensor TARGET=mikro-e USE_CC2520=1 USE_SERIAL_PADS=$(SER) CHANNEL=$(CH) PAN_ID=$(ID); fi
endif

# Copy files to build/output/
copy_contiki: get_kit_app
	mkdir -p $(DIR__BUILD)/output/contiki
	@if [ $(KIT_APP_NO) -eq "1" ]; then cp $(DIR__CKT)/packages/button-sensor/lwm2m-client-button-sensor.hex $(DIR__BUILD)/output/contiki/; fi
	@if [ $(KIT_APP_NO) -eq "2" ]; then cp $(DIR__CKT)/packages/motion-sensor/lwm2m-client-motion-sensor.hex $(DIR__BUILD)/output/contiki/; fi

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

#Clean Contiki
.PHONY: clean_contiki
clean_contiki: get_kit_app
	@if [ $(KIT_APP_NO) -eq "1" ]; then $(MAKE) -C $(DIR__CKT)/packages/button-sensor TARGET=mikro-e clean; fi
	@if [ $(KIT_APP_NO) -eq "2" ]; then $(MAKE) -C $(DIR__CKT)/packages/motion-sensor TARGET=mikro-e clean; fi

.PHONY: clean_feeds
clean_feeds:
	cd $(DIR__OPENWRT); \
	rm -rf .config feeds.conf tmp/ feeds;

.PHONY: clean_binaries
clean_binaries:
	rm -rf $(DIR__BUILD)/output/
