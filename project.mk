# inter-module dependencies
DEPS += cmb_md5sums.txt

CLEANFILES += cmb_md5sums.txt

MK_FILES = $(wildcard .includes/*.mk)

cmb_md5sums.txt: Makefile $(MK_FILES)
	$(NO_ECHO)md5sum Makefile $(MK_FILES) > $@

.PHONY: install
install: $(TARBALL)
	cpanm -n -v -l $(HOME) $<

