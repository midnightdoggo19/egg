VERSION := 0

all: assemble

clean:
	-rm -r egg *.gz egg-v$(VERSION).deb

build: egg.sh
	mkdir -vp egg/DEBIAN egg/usr/bin egg/usr/share/doc/egg/ egg/usr/share/man/man1/ egg/etc

	gzip --best -nk changelog.Debian egg.1

	cp egg.sh egg/usr/bin/egg
	cp control egg/DEBIAN
	cp changelog.Debian.gz egg/usr/share/doc/egg/changelog.gz
	cp LICENSE egg/usr/share/doc/egg/copyright
	cp egg.1.gz egg/usr/share/man/man1/

	touch egg/etc/egg.conf

	chmod -R 0755 egg

	dpkg-deb --root-owner-group --build egg
	mv egg.deb egg-v$(VERSION).deb
	@echo Ding!

assemble: build egg-v$(VERSION).deb
	-lintian egg-v$(VERSION).deb

.PHONY: clean build
