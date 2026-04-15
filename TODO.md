# TODOs

# 1.0.5

* [*] Split CPAN::Maker::ConfigReader into its own module and distribution file
* [*] Bootstrapper uses --config || CPAN_MAKER_CONFIG env var || ~/.gitconfig
* [*] CPAN_MAKER_CONFIG make variable flows into $(shell ...) config reader calls
* [*] perl.mk with ifeq-gated pattern rules
* [*] SYNTAX_CHECKING, PERLTIDYRC, PERLCRITICRC make variables via ConfigReader
* [*] PERLINCLUDE defaulting to -I lib
* [*] PERLWC_SKIP escape hatch documented in project.mk section
* [ ] Update ConfigReader entry in SEE ALSO to reflect promoted status

# 1.0.4

* [x] make update / update.mk
* [x] make upgrade / upgrade.mk
* [x] -include project.mk
* [x] Extending the build system documentation
* [x] make cpanm

# 1.0.3

* [x] validate module names
* [x] read arbitrary .ini files
* [x] --resources flag
* [x] make help
* [x] make modulino MODULINO_NAME=Foo::Bar
* [x] add TOC to POD
* [x] make git
* [x] add .gitignore to projects
* [x] import modules and scripts

# 1.0.2

* [x] conditionally create modulino in bin directory from modulino.tmpl
* [x] conditionally separate POD from .pm files
