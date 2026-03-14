VERSION := 1.0.0

all: assemble

clean:
	-rm -r build egg-v$(VERSION).deb

build: src/
	cp -vr src/ build

	gzip --best -nk build/usr/share/doc/egg/changelog.Debian build/usr/share/man/man1/egg.1

	cp LICENSE build/usr/share/doc/egg/copyright

	mv build/usr/share/doc/egg/changelog.Debian.gz build/usr/share/doc/egg/changelog.gz
	rm build/usr/share/doc/egg/changelog.Debian build/usr/share/man/man1/egg.1

	mv build/usr/bin/egg.sh build/usr/bin/egg

	dpkg-deb --root-owner-group --build build
	mv build.deb egg-v$(VERSION).deb
	@echo Ding!

assemble: build egg-v$(VERSION).deb
	-lintian egg-v$(VERSION).deb

.PHONY: clean build
