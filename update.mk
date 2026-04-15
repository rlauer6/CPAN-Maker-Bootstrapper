#-*- mode: makefile; -*-

MANAGED_FILES = \
    Makefile.txt \
    git.mk \
    help.mk \
    update.mk \
    upgrade.mk \
    version.mk \
    release-notes.mk \
    modulino.tmpl

BOOTSTRAPPER_DIST_DIR := $(shell perl -MFile::ShareDir=dist_dir \
    -e 'print dist_dir(q{CPAN-Maker-Bootstrapper})' 2>/dev/null)

.PHONY: update

update: ## update managed project files from the installed bootstrapper
	@for f in $(MANAGED_FILES); do \
	  src="$(BOOTSTRAPPER_DIST_DIR)/$$f"; \
	  test -e "$$src" || continue; \
	  cp "$$src" "$$f"; \
	done; \
	mv Makefile.txt Makefile; \
	echo "Files updated. Review changes with: git diff"
