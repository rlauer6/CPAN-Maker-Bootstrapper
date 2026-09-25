# inter-module dependencies
DEPS += cmb_md5sums.txt

MK_FILES = $(wildcard .includes/*.mk)

cmb_md5sums.txt: Makefile $(MK_FILES)
	$(NO_ECHO)md5sum Makefile $(MK_FILES) > $@

.PHONY: install
install: $(TARBALL)
	cpm install -L $(HOME) --resolver 02packages,https://cpan.openbedrock.net/orepan2 $<

