# ./lib/CPAN/Maker/Bootstrapper.pm.in
./lib/CPAN/Maker/Bootstrapper.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Role/Init.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/Init.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/Init.pm: \
    ./lib/CPAN/Maker/Bootstrapper/ConfigReader.pm \
    ./lib/CPAN/Maker/Bootstrapper/Constants.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/ReconcileDeps.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/ReconcileDeps.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Role/DepsFilter.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/Version.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/Version.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Constants.pm

