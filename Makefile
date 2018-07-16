BINDIR=/usr/local/bin
MANDIR=/usr/share/man

all:
	@echo "Run `[sudo] make install` to install this software"

install: $(BINDIR)/ffmk $(MANDIR)/ffmk.1

$(BINDIR)/ffmk: ffmk
	cp $< $@

$(MANDIR)/man1/ffmk.1: ffmk
	gzip <$< >$@
