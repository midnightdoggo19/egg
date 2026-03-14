VERSION := 0

all: build

clean:
	-rm -r egg changelog.Debian.gz

build: egg.sh
	mkdir -vp egg/DEBIAN egg/usr/bin egg/usr/share/doc/egg/

	gzip --best -nk changelog.Debian

	cp egg.sh egg/usr/bin/
	cp control egg/DEBIAN
	cp changelog.Debian.gz egg/usr/share/doc/egg/

	chmod -R 0755 egg

	dpkg-deb --root-owner-group --build egg
	mv egg.deb egg-v$(VERSION).deb
	@echo Ding!

assemble: build egg-v$(VERSION).deb
	lintian egg-v$(VERSION).deb

.PHONY: clean build
