include config.mk

BINDIR=$(PREFIX)/bin
MANDIR=$(PREFIX)/share/man

BINARIES=ffmk ffextract
MANPAGES=ffmk.1.gz ffextract.1.gz

VERSION=0.9

all: man
	@echo "Run \`[sudo] make install\` to install this software"

install: install-bin install-man
	@echo "Run \'[sudo] make uninstall\` to uninstall this software"

install-bin: $(addprefix $(BINDIR)/,$(BINARIES))
	@echo " → Installed binaries"

install-man: $(addprefix $(MANDIR)/man1/,$(MANPAGES))
	@echo " → Installed man pages"

uninstall: uninstall-man uninstall-bin

uninstall-man:
	- @rm -Rf $(addprefix $(MANDIR)/man1/,$(MANPAGES))
	@echo " → Uninstalled man pages."

uninstall-bin:
	- @rm -Rf $(addprefix $(BINDIR)/,$(BINARIES))
	@echo " → Uninstalled binaries."

man: $(basename $(MANPAGES))

package: pkgdirs $(addprefix $(PACKAGE)$(BINDIR)/,$(BINARIES)) $(addprefix $(PACKAGE)$(MANDIR)/man1/,$(MANPAGES))

$(PACKAGE)$(BINDIR)/%: %
	@cp $< $@
	@chmod +x $@

$(PACKAGE)$(MANDIR)/man1/%.1.gz: %.1
	@gzip <$< >$@

pkgdirs:
	@mkdir -p $(PACKAGE)$(BINDIR)
	@mkdir -p $(PACKAGE)$(MANDIR)/man1

clean:
	- @rm $(basename $(MANPAGES))
	@echo " → Cleaned working directory"

$(BINDIR)/%: %
	@cp $< $@
	@chmod +x $@

$(MANDIR)/man1/%.1.gz: %.1
	@gzip <$< >$@

%.1: %
	@pod2man $< $@

result.png: demo.fm ffmk
	@./ffmk <$< | ./ffextract result | ff2png >$@
