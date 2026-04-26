# inter-module dependencies
$(eval $(call find-files,ROLES,lib/CPAN/Maker/Bootstrapper/Role,*.in))

lib/CPAN/Maker/Bootstrapper.pm: \
  lib/CPAN/Maker/Bootstrapper/Constants.pm \
  lib/CPAN/Maker/Bootstrapper/ConfigReader.pm \
  $(ROLES)
