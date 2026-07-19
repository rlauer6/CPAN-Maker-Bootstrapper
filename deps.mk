# ./lib/CPAN/Maker/Bootstrapper.pm.in
./lib/CPAN/Maker/Bootstrapper.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Role/Init.pm \
    ./lib/CPAN/Maker/Bootstrapper/Role/LLM/Utils.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/Init.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/Init.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Constants.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/LLM/Annotator.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/LLM/Annotator.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Constants.pm \
    ./lib/Text/ASCIITable/FixANSI.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/LLM/Models.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/LLM/Models.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Role/LLM/Utils.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/LLM/ReleaseNotes.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/LLM/ReleaseNotes.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Constants.pm \
    ./lib/Git/ReleaseDiffs.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/LLM/Reviewer.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/LLM/Reviewer.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Constants.pm

# ./lib/CPAN/Maker/Bootstrapper/Role/LLM/Utils.pm.in
./lib/CPAN/Maker/Bootstrapper/Role/LLM/Utils.pm: \
    ./lib/CPAN/Maker/Bootstrapper/Constants.pm

