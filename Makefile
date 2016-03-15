
all: openwrt contiki
	echo "Done!"

# Building OpenWRT
openwrt/feeds.conf:
	cd ../dist/openwrt; \
	cp ../../build/feeds.conf .; \
	./scripts/feeds update -a; \
	./scripts/feeds install -a;

openwrt/.config: openwrt/feeds.conf
	cat creator-kit.config > ../dist/openwrt/.config
	$(MAKE) -C ../dist/openwrt defconfig

.PHONY: openwrt
openwrt: openwrt/.config
	$(MAKE) -C ../dist/openwrt V=s

# Building Contiki apps
.PHONY: contiki
contiki:
	$(MAKE) -C ../packages/flow_led_actuator TARGET=mikro-e 
	$(MAKE) -C ../packages/flow_button_sensor TARGET=mikro-e 

# Clean OpenWRT
# Deletes contents of the directories /bin and /build_dir
.PHONY: clean_openwrt
clean_openwrt:
	 $(MAKE) -C ../dist/openwrt clean

#Clean Contiki
.PHONY: clean_contiki
clean_contiki:
	$(MAKE) -C ../packages/flow_led_actuator TARGET=mikro-e clean
	$(MAKE) -C ../packages/flow_button_sensor TARGET=mikro-e clean

clean: clean_openwrt clean_contiki

.PHONY: clean_feeds
clean_feeds:
	cd ../dist/openwrt; \
	rm -rf .config feeds.conf tmp/ feeds;
