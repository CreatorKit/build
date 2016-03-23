
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
	$(MAKE) -C ../dist/openwrt

.PHONY: clean_feeds
clean_feeds:
	cd ../dist/openwrt; \
	rm -rf .config feeds.conf tmp/ feeds;

# Building Contiki apps
.PHONY: contiki
contiki:
	$(MAKE) -C ../packages/led-actuator TARGET=mikro-e
	$(MAKE) -C ../packages/button-sensor TARGET=mikro-e

# Clean OpenWRT
# Deletes contents of the directories /bin and /build_dir
.PHONY: clean_openwrt
clean_openwrt:
	 $(MAKE) -C ../dist/openwrt clean

#Clean Contiki
.PHONY: clean_contiki
clean_contiki:
	$(MAKE) -C ../packages/led-actuator TARGET=mikro-e clean
	$(MAKE) -C ../packages/button-sensor TARGET=mikro-e clean

clean: clean_openwrt clean_feeds clean_contiki
