# inter-module dependencies
$(eval $(call find-files,ROLES,lib/CPAN/Maker/Bootstrapper/Role,*.in))

lib/CPAN/Maker/Bootstrapper/Role/LLM/Annotator.pm: \
  lib/Text/ASCIITable/FixANSI.pm

lib/CPAN/Maker/Bootstrapper.pm: \
  lib/CPAN/Maker/Bootstrapper/Constants.pm \
  lib/CPAN/Maker/Bootstrapper/ConfigReader.pm \
  $(ROLES)

DEPS += cmb_md5sums.txt

CLEANFILES += cmb_md5sums.txt

MK_FILES = $(wildcard .includes/*.mk)

cmb_md5sums.txt: Makefile $(MK_FILES)
	$(NO_ECHO)md5sum Makefile $(MK_FILES) > $@

.PHONY: install
install: $(TARBALL)
	cpanm -n -v -l $(HOME) $<
