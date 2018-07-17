BINDIR=/usr/local/bin
MANDIR=/usr/share/man

VERSION=0.9

all:
	@echo "Run `[sudo] make install` to install this software"

install: $(BINDIR)/ffmk $(MANDIR)/ffmk.1

$(BINDIR)/ffmk: ffmk
	cp $< $@

ffmk.1: ffmk
	pod2man $< $@

$(MANDIR)/man1/ffmk.1: ffmk.1
	gzip <$< >$@

result.png: demo.fm ffmk
	./ffmk <$< --files
	ff2png <result.ff >$@
	rm *.ff
