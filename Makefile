
all: openwrt contiki copy_binaries
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
	$(MAKE) $(SUBMAKEFLAGS) -C ../dist/openwrt

# Building Contiki apps
.PHONY: contiki
contiki:
	$(MAKE) -C ../packages/led-actuator TARGET=mikro-e
	$(MAKE) -C ../packages/button-sensor TARGET=mikro-e

.PHONY: copy_binaries
copy_binaries:
	mkdir -p output/contiki
	cp ../packages/led-actuator/lwm2m-client-led-actuator.hex output/contiki/
	cp ../packages/button-sensor/lwm2m-client-button-sensor.hex output/contiki/
	mkdir -p output/openwrt
	find ../dist/openwrt/bin/pistachio/ -maxdepth 1 -type f -exec cp {} output/openwrt/ \;

# Clean OpenWRT
# Deletes contents of the directories /bin and /build_dir
.PHONY: clean_openwrt
clean_openwrt:
	$(MAKE) -C ../dist/openwrt clean

# Clean Contiki
.PHONY: clean_contiki
clean_contiki:
	$(MAKE) -C ../packages/led-actuator TARGET=mikro-e clean
	$(MAKE) -C ../packages/button-sensor TARGET=mikro-e clean

.PHONY: clean_feeds
clean_feeds:
	cd ../dist/openwrt; \
	rm -rf .config feeds.conf tmp/ feeds;

clean: clean_openwrt clean_feeds clean_contiki
