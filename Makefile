VERSION := 0.0.0

all: assemble

clean:
	-rm -r build egg-v$(VERSION).deb

build: src/
	cp -vr src/ build

	gzip --best -nk changelog.Debian egg.1

	mv changelog.Debian.gz build/usr/share/doc/egg/changelog.gz
	cp LICENSE build/usr/share/doc/egg/copyright
	mv egg.1.gz build/usr/share/man/man1/
	mv build/usr/bin/egg.sh build/usr/bin/egg

	dpkg-deb --root-owner-group --build build
	mv build.deb egg-v$(VERSION).deb
	@echo Ding!

assemble: build egg-v$(VERSION).deb
	-lintian egg-v$(VERSION).deb

.PHONY: clean build
