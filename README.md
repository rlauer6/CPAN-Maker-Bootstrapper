<a id="table-of-contents" class="anchor" aria-label="Permalink: Table of Contents" href="#table-of-contents"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">Table of Contents</h1>
<ul>
<li><a href="#name">NAME</a></li>
<li><a href="#synopsis">SYNOPSIS</a></li>
<li><a href="#description">DESCRIPTION</a></li>
<li>
<a href="#quick-start">QUICK START</a>
<ul>
<li><a href="#next-steps">Next Steps</a></li>
</ul>
</li>
<li>
<a href="#why-you-should-consider-using-cpanmakerbootstrapper">WHY YOU SHOULD CONSIDER USING CPAN::Maker::Bootstrapper</a>
<ul>
<li><a href="#the-stack">The Stack</a></li>
<li><a href="#best-practices-out-of-the-box">Best Practices Out of the Box</a></li>
<li><a href="#perl-quality-tools">Perl Quality Tools</a></li>
<li><a href="#a-gnu-make-tutorial-in-disguise">A GNU Make Tutorial in Disguise</a></li>
</ul>
</li>
<li>
<a href="#importing-files">IMPORTING FILES</a>
<ul>
<li><a href="#what-gets-imported">What Gets Imported</a></li>
<li><a href="#module-name-requirement">Module Name Requirement</a></li>
<li><a href="#the-build-after-import">The Build After Import</a></li>
<li><a href="#next-steps-after-a-successful-import">Next Steps After a Successful Import</a></li>
<li><a href="#limitations">Limitations</a></li>
<li><a href="#importing-a-clisimple-scaffold-tarball">Importing a CLI::Simple Scaffold Tarball</a></li>
</ul>
</li>
<li>
<a href="#configuration">CONFIGURATION</a>
<ul>
<li><a href="#environment">Environment</a></li>
</ul>
</li>
<li><a href="#installed-project-files">INSTALLED PROJECT FILES</a></li>
<li>
<a href="#the-project-makefile">THE PROJECT MAKEFILE</a>
<ul>
<li><a href="#readmemd">README.md</a></li>
</ul>
</li>
<li>
<a href="#commands">COMMANDS</a>
<ul>
<li><a href="#llm-commands">LLM Commands</a></li>
</ul>
</li>
<li><a href="#options">OPTIONS</a></li>
<li>
<a href="#the-review-workflow">THE REVIEW WORKFLOW</a>
<ul>
<li><a href="#overview">Overview</a></li>
<li><a href="#dry-run-mode">Dry Run Mode</a></li>
<li><a href="#dispositions">Dispositions</a></li>
<li><a href="#diminishing-returns-and-when-to-stop">Diminishing Returns and When to Stop</a></li>
<li><a href="#the-release-artifact">The Release Artifact</a></li>
<li><a href="#cost-management">Cost Management</a></li>
<li><a href="#see-also">See Also</a></li>
</ul>
</li>
<li>
<a href="#prompt-profiles">PROMPT PROFILES</a>
<ul>
<li>
<a href="#using-profiles">Using Profiles</a>
<ul>
<li><a href="#built-in-profiles">Built-in Profiles</a></li>
<li><a href="#creating-custom-profiles">Creating Custom Profiles</a></li>
<li><a href="#planned-profiles">Planned Profiles</a></li>
</ul>
</li>
</ul>
</li>
<li>
<a href="#extending-the-build-system">EXTENDING THE BUILD SYSTEM</a>
<ul>
<li><a href="#how-the-makefile-works">How the Makefile Works</a></li>
<li><a href="#what-belongs-in-projectmk">What Belongs in <code>project.mk</code></a></li>
<li><a href="#what-does-not-belong-in-projectmk">What does NOT belong in project.mk</a></li>
<li><a href="#keeping-the-build-system-up-to-date">Keeping the build system up to date</a></li>
<li><a href="#automatic-drift-and-update-checks">Automatic Drift and Update Checks</a></li>
<li><a href="#what-you-should-never-modify">What You Should Never Modify</a></li>
<li><a href="#dependencies-management">Dependencies Management</a></li>
</ul>
</li>
<li>
<a href="#modulinos">MODULINOS</a>
<ul>
<li>
<a href="#continuous-integration">Continuous Integration</a>
<ul>
<li><a href="#running-builder-manually">Running builder manually</a></li>
<li><a href="#environment-variables">Environment variables</a></li>
<li><a href="#override-files">Override files</a></li>
<li><a href="#make-build-ci-variables">make build-ci variables</a></li>
<li><a href="#see-also">See Also</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#prerequisites">PREREQUISITES</a></li>
<li><a href="#caveats">CAVEATS</a></li>
<li>
<a href="#faq">FAQ</a>
<ul>
<li><a href="#my-build-is-failing-with-a-module-not-found-error-during-syntax">My build is failing with a module not found error during syntax</a></li>
<li><a href="#how-do-i-do-a-fast-build-during-development">How do I do a fast build during development?</a></li>
<li><a href="#how-do-i-add-a-new-module-or-script-to-the-project">How do I add a new module or script to the project?</a></li>
<li><a href="#how-do-i-include-additional-files-in-the-distribution">How do I include additional files in the distribution?</a></li>
<li><a href="#i-want-to-pin-a-version-or-add-a-module-the-scanner-missed">I want to pin a version or add a module the scanner missed</a></li>
<li><a href="#i-want-to-exclude-a-module-the-scanner-found">I want to exclude a module the scanner found</a></li>
<li><a href="#i-edited-a-pm-file-and-my-changes-disappeared">I edited a .pm file and my changes disappeared</a></li>
<li><a href="#why-does-my-build-say-it-has-drifted-from-the-installed-bootstrapper">Why does my build say it has drifted from the installed bootstrapper?</a></li>
<li><a href="#make-says-nothing-to-do-but-my-source-changed">make says nothing to do but my source changed</a></li>
<li><a href="#how-do-i-disable-scanning-temporarily">How do I disable scanning temporarily?</a></li>
<li><a href="#how-do-i-disable-syntax-checking-temporarily">How do I disable syntax checking temporarily?</a></li>
<li><a href="#how-do-i-upgrade-the-build-system">How do I upgrade the build system?</a></li>
<li><a href="#i-want-to-add-a-bash-script-to-my-distribution">I want to add a bash script to my distribution</a></li>
<li><a href="#what-is-make-release-notes-used-for">What is <code>make release-notes</code> used for?</a></li>
<li><a href="#can-i-distribute-the-pod-in-my-modules-separately">Can I distribute the POD in my modules separately?</a></li>
<li><a href="#the-dependency-resolver-keeps-adding-a-file-i-dont-want-to">The dependency resolver keeps adding a file I don't want to</a></li>
<li><a href="#something-still-doesnt-work---how-do-i-report-an-issue">Something still doesn't work - how do I report an issue?</a></li>
</ul>
</li>
<li><a href="#see-also">SEE ALSO</a></li>
<li>
<a href="#dependencies">DEPENDENCIES</a>
<ul>
<li><a href="#required-for-ai-commands">Required for AI Commands</a></li>
<li><a href="#recommend-packages">Recommend Packages</a></li>
</ul>
</li>
<li><a href="#version">VERSION</a></li>
<li><a href="#author">AUTHOR</a></li>
<li><a href="#license">LICENSE</a></li>
</ul>
<a id="name" class="anchor" aria-label="Permalink: NAME" href="#name"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">NAME</h1>
<p>CPAN::Maker::Bootstrapper - Scaffold a new CPAN distribution in one command</p>
<a id="synopsis" class="anchor" aria-label="Permalink: SYNOPSIS" href="#synopsis"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">SYNOPSIS</h1>
<pre><code># Create a configuration file (recommended first-time setup)
cmb create-config &gt; ~/.cpan-makerrc
export CPAN_MAKER_CONFIG=$HOME/.cpan-makerrc

# Create a new plain Perl module project
cmb --module  My::New::Module

# Create a CLI module project (inherits from CLI::Simple)
cmb --module My::New::CLI --stub cli

# Use a custom stub
cmb --module My::Module --stub /path/to/mystub.pm

# Import files from another project
cmb --module My::Module \
 -I /path/to/my-module/lib -I /path/to/my-module/bin \
 --installdir /tmp/My-Module

# Install into a specific directory
cmb --module My::Module --installdir ~/git/My-Module

# Override git identity
cmb --module My::Module --username "Rob Lauer" --email rob@example.org

# Run a code review on a module (set API key in environment)
export LLM_API_KEY=$(cat ~/.ssh/anthropic-api-key)
cmb code-review lib/My/Module.pm    
</code></pre>
<a id="description" class="anchor" aria-label="Permalink: DESCRIPTION" href="#description"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">DESCRIPTION</h1>
<p><a href="https://github.com/rlauer6/CPAN-Maker-Bootstrapper/actions/workflows/build.yml"><img src="https://github.com/rlauer6/CPAN-Maker-Bootstrapper/actions/workflows/build.yml/badge.svg" alt="CPAN::Maker::Bootstrapper" style="max-width: 100%;"></a></p>
<p><code>CPAN::Maker::Bootstrapper</code> scaffolds a new Perl project that
leverages <a href="https://metacpan.org/pod/CPAN%3A%3AMaker" rel="nofollow">CPAN::Maker</a> to create a ready-built CPAN distribution. It
installs a project Makefile, a <code>buildspec.yml</code> pre-populated and
ready to feed to <code>CPAN::Maker</code>, optional stub source file and test
file, and supporting makefile snippets that implement the bootstrapper
framework. It then runs <code>make</code> to generate your distribution tarball.</p>
<p>The result is a project that can produce a distributable tarball with
a single <code>make</code> invocation. As you iterate on your application, new
dependencies are discovered and added to the build system
automatically.</p>
<p><code>CPAN::Maker::Bootstrapper</code> also provides AI-assisted development
tools via the Anthropic Claude API. These include iterative code
review with structured finding annotations, POD documentation review,
optional POD <strong>generation</strong>, and AI-generated release notes. See <a href="#llm-commands">"LLM
Commands"</a> and <a href="#the-review-workflow">"THE REVIEW WORKFLOW"</a> for details.</p>
<p><em>NOTE: Check out the
<a href="https://github.com/rlauer6/CPAN-Maker-Bootstrapper/tree/main/release-notes">release-notes</a>
directory in the GitHub project for examples of release notes generated by the LLM.</em></p>
<a id="quick-start" class="anchor" aria-label="Permalink: QUICK START" href="#quick-start"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">QUICK START</h1>
<p>Install the bootstrapper and its dependencies:</p>
<pre><code>cpanm CPAN::Maker::Bootstrapper
</code></pre>
<p><em>Note: Before scaffolding your first project, consider running <code>create-config</code>
to set up a personal configuration file - it pre-populates your git
identity, GitHub username, and preferred project directory so you never
have to pass them on the command line. See <a href="#configuration">"CONFIGURATION"</a> for details.</em></p>
<p>Scaffold a new project:</p>
<pre><code>cmb --module My::Module --installdir ~/git/My-Module
</code></pre>
<p>The bootstrapper creates the project directory, installs the build
system, generates stub source and test files, and runs <code>make</code>
automatically. By the time it finishes you already have a working
distribution tarball in <code>~/git/My-Module</code>.</p>
<p><em>By default the final build step applies full linting: syntax
checking (<code>perl -wc</code>), perltidy conformance, and perlcritic at its
default severity (5 - the most severe violations only). If your stub
or imported source isn't tidy, has a severity-5 perlcritic violation,
or fails to compile, the build - and therefore <code>install</code> - will fail.
Disable these gates with environment variables if you want to
bootstrap first and clean up after:</em></p>
<pre><code>make LINT=off SKIP_TESTS=1
</code></pre>
<p><em><code>LINT</code> is interpreted by the build system installed by this
module; <code>SKIP_TESTS</code> is interpreted by <a href="https://metacpan.org/pod/CPAN%3A%3AMaker" rel="nofollow">CPAN::Maker</a> to skip
running the test suite when building the distribution tarball.</em></p>
<p><strong>Have an existing project?</strong></p>
<pre><code>cmb -I lib -I bin --module Foo::Bar
</code></pre>
<a id="next-steps" class="anchor" aria-label="Permalink: Next Steps" href="#next-steps"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Next Steps</h2>
<ul>
<li>
<p>Review the generated files</p>
<p>...particularly <code>buildspec.yml</code> which controls how the distribution
is built as well as <code>requires</code> and <code>test-requires</code> which list your
module's dependencies. Your git identity is pre-populated from
<code>~/.gitconfig</code> but you may want to adjust the description or resource
URLs.</p>
<p>See <a href="https://metacpan.org/pod/CPAN%3A%3AMaker" rel="nofollow">CPAN::Maker</a> for details regarding <code>buildspec.yml</code>.</p>
</li>
<li>
<p>Edit the generated stub in <code>lib/My/Module.pm.in</code>.</p>
<p>This is your primary source file - never edit the generated <code>.pm</code> file
directly as it will be overwritten on the next <code>make</code>.</p>
</li>
<li>
<p>Add More Modules and Scripts</p>
<p>As your project grows, add new modules to <code>lib/</code> and scripts to
<code>bin/</code> as <code>.pm.in</code> and <code>.pl.in</code> files respectively. The build
system discovers them automatically - no changes to the Makefile
required. Add new test files to <code>t/</code> as <code>.t</code> files.</p>
</li>
<li>
<p>Rebuild Your Distribution</p>
<p>When you are ready to build:</p>
<pre><code>  make
</code></pre>
<p>This scans your source files for dependencies, regenerates <code>requires</code>
and <code>test-requires</code>, generates <code>README.md</code> from your POD, and
produces a distributable tarball.</p>
</li>
<li>
<p>Verify Your Tarball Installs Cleanly</p>
<p>To verify your distribution installs cleanly:</p>
<pre><code>  cpanm --local-lib=$HOME My-Module-*.tar.gz
</code></pre>
</li>
<li>
<p>Put Your Project Under Source Control</p>
<p>To initialize version control and make your first commit:</p>
<pre><code>  make git
</code></pre>
<p>Set <code>NO_COMMIT=1</code> if you don't want to commit yet.</p>
<pre><code>  make git NO_COMMIT=1
</code></pre>
</li>
<li>
<p>Learn More About <code>CPAN::Maker::Bootstrapper</code></p>
<p>See <a href="#extending-the-build-system">"EXTENDING THE BUILD SYSTEM"</a> for customizing the build,
dependency management details. See <a href="#faq">"FAQ"</a> for common
questions and recipes.</p>
</li>
</ul>
<a id="why-you-should-consider-using-cpanmakerbootstrapper" class="anchor" aria-label="Permalink: WHY YOU SHOULD CONSIDER USING CPAN::Maker::Bootstrapper" href="#why-you-should-consider-using-cpanmakerbootstrapper"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">WHY YOU SHOULD CONSIDER USING CPAN::Maker::Bootstrapper</h1>
<p>If you have ever reached for Jenkins, GitHub Actions, CircleCI, or a
sprawling shell script to automate your Perl builds, consider what
those tools actually require: a server or cloud account, a proprietary
YAML DSL, plugin ecosystems with their own release cycles, containers,
agents, and configuration files that only run in one specific
environment.</p>
<p>The <code>CPAN::Maker</code> build system runs everywhere Perl runs - your
laptop, a remote EC2 instance, a colleague's workstation - with no
setup beyond <code>cpanm CPAN::Maker::Bootstrapper</code>. <code>git clone &amp;&amp; make</code>
is always sufficient to build a fresh checkout.</p>
<a id="the-stack" class="anchor" aria-label="Permalink: The Stack" href="#the-stack"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">The Stack</h2>
<p>The build system is built on three tools that have been solving these
problems correctly for decades:</p>
<ul>
<li>
<strong>GNU make</strong> - dependency tracking, incremental builds, the
target/prerequisite model is still the clearest expression of <em>build
this from that</em>. A Makefile from 1990 still runs today.</li>
<li>
<strong>bash</strong> - process orchestration, file manipulation,
conditionals, the Unix toolkit. Available on every system you will
ever deploy to.</li>
<li>
<strong>Perl</strong> - text processing, CPAN ecosystem access, JSON, YAML,
HTTP - anything complex enough to warrant a real language, right there
in your build recipes without shelling out to another runtime.</li>
</ul>
<p>Together they give you a complete, auditable, version-controlled build
system that is trivially debuggable with <code>make -n</code> and <code>bash -x</code>,
self-documents via <code>make help</code>, and needs no external services to run.</p>
<a id="best-practices-out-of-the-box" class="anchor" aria-label="Permalink: Best Practices Out of the Box" href="#best-practices-out-of-the-box"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Best Practices Out of the Box</h2>
<p>The installed build system encourages professional Perl development
habits from the start:</p>
<ul>
<li>
<strong>Source files are clearly separated</strong> - generated <code>.pm</code> and
<code>.pl</code> files live alongside their <code>.pm.in</code> and <code>.pl.in</code> sources.
The build system always regenerates the <code>.pm</code> from the <code>.pm.in</code> on
change, making it clear which file you own. Never edit the generated
file directly - your changes will be overwritten on the next <code>make</code>.</li>
<li>
<strong>Dependencies are tracked automatically</strong> - <code>scandeps-static.pl</code>
scans your source files on every build, keeping <code>requires</code> and
<code>test-requires</code> current. You stay in control via pinning, sticky
entries, and skip lists.</li>
<li>
<strong>Quality gates are built in</strong> - <code>perl -wc</code> syntax checking,
<code>perltidy</code>, and <code>perlcritic</code>, <code>podchecker</code> run automatically on
every build, stopping bad code before it enters the
distribution. Gates can be selectively disabled via your configuration
file or on the command line (<code>make LINT=off</code>) when you need a faster
build during development.</li>
<li>
<strong>The build system upgrades itself</strong> - <code>make update</code> refreshes
managed build files from the installed bootstrapper; <code>make upgrade</code>
checks MetaCPAN and upgrades the bootstrapper itself.</li>
<li>
<strong>Extension without modification</strong> - <code>project.mk</code> is your
upgrade-safe extension point. Add custom targets, inter-module
dependencies, and project-specific variables there. The managed
<code>Makefile</code> is never modified directly.</li>
</ul>
<a id="perl-quality-tools" class="anchor" aria-label="Permalink: Perl Quality Tools" href="#perl-quality-tools"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Perl Quality Tools</h2>
<p>The build system supports optional Perl quality gates controlled via
your configuration file. Set the following keys in the <code>[cpan-maker]</code>
section:</p>
<pre><code>syntax-checking = on          # enables perl -wc on generated files
perltidyrc = ~/.perltidyrc    # enables perltidy stage gate
perlcriticrc = ~/.perlcriticrc # enables perlcritic stage gate
</code></pre>
<p>These can be overridden per-run from the command line:</p>
<pre><code>make SYNTAX_CHECKING=off      # disable syntax checking
make PERLTIDYRC=""            # disable tidy gate
make PERLCRITICRC=""          # disable critic gate
</code></pre>
<p>Add modules that cannot be syntax-checked outside their runtime
environment to <code>PERLWC_SKIP</code> in <code>project.mk</code>:</p>
<pre><code>PERLWC_SKIP = bin/startup.pl
</code></pre>
<p>Add inter-module build dependencies to <code>project.mk</code> when modules
depend on each other at build time:</p>
<pre><code>lib/Foo/Bar.pm: lib/Foo.pm
</code></pre>
<p>To disable all linting at once:</p>
<pre><code>make LINT=off
</code></pre>
<p>Or use <code>make quick</code> to disable both scanning and linting in one step.</p>
<a id="a-gnu-make-tutorial-in-disguise" class="anchor" aria-label="Permalink: A GNU Make Tutorial in Disguise" href="#a-gnu-make-tutorial-in-disguise"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">A GNU Make Tutorial in Disguise</h2>
<p>The <code>.includes/</code> directory is also a practical demonstration of
advanced GNU make techniques that most developers never encounter -
working, production-tested examples you can learn from and adapt:</p>
<ul>
<li>Pattern rules and sentinel files for incremental quality gates</li>
<li>
<code>define</code>/<code>endef</code> snippets - reusable shell and Perl code
blocks exported as make variables, eliminating duplication across
recipes</li>
<li>
<code>$(shell ...)</code>, <code>$(eval ...)</code>, <code>$(call ...)</code>,
<code>$(filter-out ...)</code>, <code>$(addprefix ...)</code>, <code>$(patsubst ...)</code> - the
full make function toolkit in real use</li>
<li>
<code>?=</code>, <code>:=</code>, <code>+=</code>, and <code>=</code> - all four assignment operators
with their distinct evaluation semantics put to work</li>
<li>Order-only prerequisites, <code>.DEFAULT_GOAL</code>, <code>-include</code>, and
<code>.SHELLFLAGS := -ec</code> - advanced directives that tame complex builds</li>
<li>Trap-based temp file cleanup, <code>mktemp</code>, and bash <code>[[ ]]</code>&gt;
conditionals inside make recipes</li>
<li>Perl snippets exported into make via <code>$(value ...)</code> and
<code>export</code> - leveraging Perl's text processing power directly in the
build</li>
</ul>
<p>If GNU make is the cast-iron pan of build tools - virtually
indestructible, infinitely useful, and unfairly overlooked in favor of
shinier alternatives - then <code>CPAN::Maker::Bootstrapper</code> is the recipe
book that shows you what it can really do.</p>
<a id="importing-files" class="anchor" aria-label="Permalink: IMPORTING FILES" href="#importing-files"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">IMPORTING FILES</h1>
<p>The <code>--import|-I</code> option allows you to bring existing Perl source
files into a new Bootstrapper project. This is the primary mechanism
for migrating an existing project or consuming a scaffold tarball
generated by <code>cli-simple -scaffold</code>.</p>
<p>The <code>--import</code> option may be specified multiple times to import from
several directories in a single operation:</p>
<pre><code>cmb --module My::Script \
  --import /path/to/roles \
  --import /path/to/bin \
  --installdir .
</code></pre>
<a id="what-gets-imported" class="anchor" aria-label="Permalink: What Gets Imported" href="#what-gets-imported"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">What Gets Imported</h2>
<p>The importer recursively scans the path provided by <code>--import</code> and
brings in the following file types:</p>
<ul>
<li>
<p><code>.pm</code> files - copied to <code>lib/</code> as <code>.pm.in</code> source files,
preserving the directory structure implied by the package name</p>
</li>
<li>
<p><code>.pl</code> files - copied to <code>bin/</code> as <code>.pl.in</code> source files</p>
</li>
<li>
<p><code>.t</code> files - copied to <code>t/</code></p>
</li>
<li>
<p>Executable files - copied to <code>bin/</code> as <code>.in</code> files.</p>
<p><em>Note: Executable files are imported with their execute permission
removed. The build system sets permissions appropriately when
generating the final files from the <code>.in</code> sources.</em></p>
</li>
</ul>
<p>All imported files receive the <code>.in</code> extension because they become
source inputs to the build system. The build generates the final
<code>.pm</code>, <code>.pl</code>, and script files from these sources, substituting
version tokens and running syntax checks along the way.</p>
<a id="module-name-requirement" class="anchor" aria-label="Permalink: Module Name Requirement" href="#module-name-requirement"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Module Name Requirement</h2>
<p>When using <code>--import</code> you must also specify <code>--module</code> with the
primary module name of the distribution. The importer cannot infer
the module name from the imported files alone:</p>
<pre><code>cmb --module My::Script --import /path/to/source --installdir .
</code></pre>
<a id="the-build-after-import" class="anchor" aria-label="Permalink: The Build After Import" href="#the-build-after-import"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">The Build After Import</h2>
<p>After creating the project source tree the importer runs <code>make</code>
with linting disabled but syntax checking and dependency scanning
enabled:</p>
<pre><code>make LINT=off SYNTAX_CHECKING=on SCAN=on
</code></pre>
<p>This serves two purposes - it validates that the imported files are
syntactically correct Perl, and it runs <code>scandeps-static.pl</code> against
the source to seed the <code>requires</code> and <code>test-requires</code> dependency
files.</p>
<p>The build will attempt to produce a distribution tarball. If the
build fails, <code>make.log</code> and <code>make.err</code> are written to your current
working directory for diagnosis.</p>
<a id="next-steps-after-a-successful-import" class="anchor" aria-label="Permalink: Next Steps After a Successful Import" href="#next-steps-after-a-successful-import"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Next Steps After a Successful Import</h2>
<p>After a successful build you have a complete, buildable CPAN
distribution, although it may not reflect everything you need for your
project. Typical next steps:</p>
<ul>
<li>
<ol>
<li>Review and edit the generated <code>buildspec.yml</code> - verify the
module name, author, and resource links are correct</li>
</ol>
</li>
<li>
<ol start="2">
<li>Manually import files missed by the importer</li>
</ol>
<p>Your project may want to package additional files that are installed
into the distribution's share directory. Move them into an appropriate
directory or the root of the project and add them to the
<code>buildspec.yml</code> file.</p>
<pre><code>  extra_files:
    - ChangeLog &lt;= included in distribution tarball, but not installed
    share:
      - config/some-file.ini  &lt;= installs config/some-file.in into the distribution's share directory
      - my-app.json &lt;= installs my-app.json from the root of your project into the distribution's share directory
</code></pre>
</li>
<li>
<ol start="3">
<li>Initialize a git repository with <code>make git</code>
</li>
</ol>
</li>
<li>
<ol start="4">
<li>Run <code>make tidy</code> if you have <code>perltidy</code> installed</li>
</ol>
</li>
<li>
<ol start="5">
<li>Run <code>make</code> to produce the final distribution tarball</li>
</ol>
<p>By default the recipes in the <code>Makefile</code> will perform the following
actions:</p>
<ul>
<li>
<p>Perform a syntax check (<code>perl -wc -I lib $@</code>) on your source files</p>
</li>
<li>
<p>Scan your source for dependencies</p>
<p>To turn this off:</p>
<pre><code>  make SCAN=off
</code></pre>
</li>
<li>
<p>Run <code>perltidy</code> on your source files</p>
<p>To turn this off:</p>
<pre><code>  make PERLTIDYRC=""
  make LINT=off
</code></pre>
</li>
<li>
<p>Run <code>perlcritic</code> on your source files</p>
<pre><code>  make PERLCRITICRC=""
  make LINT=off
</code></pre>
</li>
</ul>
<p>To turn off everything except syntax checking:</p>
<pre><code>  make quick
</code></pre>
</li>
<li>
<ol start="6">
<li>Test installation: <code>cpanm -n -v ./My-Script-1.0.0.tar.gz</code>
</li>
</ol>
</li>
</ul>
<a id="limitations" class="anchor" aria-label="Permalink: Limitations" href="#limitations"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Limitations</h2>
<ul>
<li>
<p><code>--import</code> cannot be used with <code>--stub</code> - they are mutually
exclusive ways to create the initial source</p>
</li>
<li>
<p>The importer uses the package declarations inside <code>.pm</code> files
to determine where to place them under <code>lib/</code>. If the importer cannot
match the filename with a package declaration inside the file, it will
warn and skip that file</p>
</li>
<li>
<p>Imported files are not tidied automatically. If you have
<code>perltidy</code> installed, run <code>make tidy</code> after import to bring the
imported code into conformance with your <code>.perltidyrc</code> before
committing</p>
</li>
<li>
<p>If your imported modules have dependencies on each other, the
syntax check phase of the build may fail because Make processes files
independently and cannot guarantee build order. Add a <code>project.mk</code>
to declare inter-module dependencies:</p>
<pre><code>  lib/My/Script.pm: \
    lib/My/Script/Role/Frobnicate.pm \
    lib/My/Script/Role/List.pm
</code></pre>
<p>Make will then build your dependencies before attempting to syntax-check
the main module. See <a href="#extending-the-build-system">"EXTENDING THE BUILD SYSTEM"</a> for details on
<code>project.mk</code>.</p>
</li>
</ul>
<a id="importing-a-clisimple-scaffold-tarball" class="anchor" aria-label="Permalink: Importing a CLI::Simple Scaffold Tarball" href="#importing-a-clisimple-scaffold-tarball"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Importing a CLI::Simple Scaffold Tarball</h2>
<p>Suppose you have a project that used <code>CLI::Simple</code> as base class and
now want to use the <code>CPAN::Maker::Bootstrapper</code> framework.</p>
<p>The <code>import-scaffold</code> command is a convenience wrapper around
<code>--import</code> specifically designed to consume tarballs generated by
<code>cli-simple -scaffold</code>:</p>
<pre><code>cmb import-scaffold my-script-roles.tar.gz --module My::Script --installdir .
</code></pre>
<p>The tarball is extracted to a temporary directory and fed to the
importer automatically. See <a href="https://metacpan.org/pod/CLI%3A%3ASimple" rel="nofollow">CLI::Simple</a> for details on generating
scaffold tarballs.</p>
<a id="configuration" class="anchor" aria-label="Permalink: CONFIGURATION" href="#configuration"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">CONFIGURATION</h1>
<p><code>cmb</code> can read your global <code>.gitconfig</code> file or
a properly formatted <code>.ini</code> file to populate some of the options used
when creating a distribution and using the AI commands. If you have a
GitHub user account add your username:</p>
<pre><code>git config --global user.github &lt;your-username&gt;
</code></pre>
<p>If you typically create projects in one directory, add the <code>basedir</code>
option:</p>
<pre><code>git config --global cpan-maker.basedir $HOME/git
</code></pre>
<p>If you want to create a different configuration file it should have at
least the following entries:</p>
<pre><code>[user]
       email = your-email@somedomain
       name = First Last
       # use to construct GitHub resource URLs
       github = github-user

[cpan-maker]
       basedir   = /home/myhome/git
       # indicates the resources section of Makefile.PL should contain github references
       resources = github
       llm-api-key-helper = cat ~/.ssh/anthropic-api-key
</code></pre>
<ul>
<li>
<p><code>llm-api-key-helper</code></p>
<p>For LLM commands (code-review, pod-review), you can specify a
shell command that outputs your API key without exposing it in shell
history:</p>
<pre><code>  llm-api-key-helper = cat ~/.ssh/anthropic-api-key
</code></pre>
<p>When set, this command is executed to retrieve the API key, avoiding
the need to pass it on the command line or set it in the environment
manually. This is the recommended secure approach.</p>
<p>See <a href="https://metacpan.org/pod/CPAN%3A%3AMaker%3A%3AConfigReader" rel="nofollow">CPAN::Maker::ConfigReader</a> for a complete description of the
configuration file.</p>
</li>
<li>
<p>Use the <code>--config</code> option to use your custom config.</p>
</li>
<li>
<p>Use <code>create-config</code> to generate a starter configuration file:</p>
<pre><code>  cmb create-config &gt; ~/.cpan-makerrc
</code></pre>
<p>Then point <code>cmb</code> at it by setting the
<code>CPAN_MAKER_CONFIG</code> environment variable in your shell profile:</p>
<pre><code>  export CPAN_MAKER_CONFIG=$HOME/.cpan-makerrc
</code></pre>
</li>
</ul>
<a id="environment" class="anchor" aria-label="Permalink: Environment" href="#environment"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Environment</h2>
<ul>
<li>
<p>LLM_API_KEY</p>
<p>Your Anthropic Claude API key. Set this before running any LLM command
(code-review, pod-review, release-notes).</p>
<p>The key is removed from environment so it is not inherited by child
processes such as 'make'. This does not protect against memory
inspection of the current process - see <a href="https://metacpan.org/pod/LLM%3A%3AAPI" rel="nofollow">LLM::API</a> for how the key is
actuall stored using a closure to prevent accidental serialization
via Dumper.</p>
<p>Avoid passing the key on the command line where it might be saved in
history and can be seen in process lists.</p>
</li>
<li>
<p>CPAN_MAKER_CONFIG</p>
<p>Path to a configuration file (in .ini format) containing user settings
such as name, email, GitHub username, and project base directory. If
not set, the bootstrapper will attempt to read settings from
~/.gitconfig.</p>
</li>
<li>
<p>SCAN</p>
<p>Controls whether dependency scanning is performed during <code>make</code>. Set
to OFF or off to disable scanning. Default is ON.</p>
</li>
</ul>
<a id="installed-project-files" class="anchor" aria-label="Permalink: INSTALLED PROJECT FILES" href="#installed-project-files"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">INSTALLED PROJECT FILES</h1>
<p>The following files are installed into the project directory:</p>
<ul>
<li>
<p><code>Makefile</code> - the complete build system. Derives all paths and
names from <code>MODULE_NAME</code> or your stub file's package name. See <a href="#the-project-makefile">"THE
PROJECT MAKEFILE"</a>.</p>
</li>
<li>
<p><code>buildspec.yml</code> - generated from the template, pre-populated
with your module name, git identity, GitHub username, and project URLs.</p>
</li>
<li>
<p><code>lib/&lt;Module/Path&gt;.pm.in</code> - stub module, populated from
either <code>class-module.pm.tmpl</code> (default) or <code>cli-module.pm.tmpl</code> (when
<code>--stub cli</code> option is used). Contains package declaration, <code>$VERSION</code>,
and a POD skeleton with your name and email from git config.</p>
<p><em>Note: All source files in <code>lib/</code> and <code>bin/</code> use the <code>.pm.in</code> / <code>.pl.in</code>
convention. These are the files you edit. The <code>.pm</code> and <code>.pl</code> files are
derived from them by the pattern rules in the Makefile, which substitute
<code>@PACKAGE_VERSION@</code> with the current value of <code>VERSION</code>. Never edit the
generated <code>.pm</code> or <code>.pl</code> files directly - your changes will be
overwritten the next time <code>make</code> runs!</em></p>
</li>
<li>
<p><code>t/00-&lt;project-name&gt;.t</code> - minimal smoke test that calls
<code>use_ok</code> on your module.</p>
</li>
<li>
<p><code>.includes/</code> - the managed build system directory. Contains
all <code>.mk</code> files installed and maintained by the bootstrapper. These
files are write-protected and should never be edited directly. Updated
by <code>make update</code>.</p>
<pre><code>  .includes/perl.mk         - pattern rules, syntax checking, tidy, critic
  .includes/git.mk          - make git target
  .includes/help.mk         - make help target
  .includes/version.mk      - make release/minor/major targets
  .includes/release-notes.mk - make release-notes target
  .includes/update.mk       - make update target
  .includes/upgrade.mk      - make upgrade/check-upgrade targets
</code></pre>
</li>
<li>
<p><code>project.mk</code> - your extension point for custom make rules,
inter-module dependencies, and project-specific variables. Never
touched by <code>make update</code>. See <a href="#extending-the-build-system">"EXTENDING THE BUILD SYSTEM"</a>.</p>
</li>
<li>
<p><code>modulino.tmpl</code> - template used by <code>make modulino</code> to
generate bash wrapper scripts for modulino-style modules.</p>
</li>
<li>
<p><code>VERSION</code> - contains the current version string in
<code>major.minor.patch</code> format. Managed by <code>make release</code>, <code>make minor</code>,
and <code>make major</code>.</p>
</li>
<li>
<p><code>ChangeLog</code> - empty placeholder, required by the distribution.</p>
</li>
<li>
<p>.prompts/</p>
<p>The first time you attempt to run <code>pod-review</code> or <code>code-review</code> the
script will populate this directory with the default prompts.</p>
</li>
</ul>
<a id="the-project-makefile" class="anchor" aria-label="Permalink: THE PROJECT MAKEFILE" href="#the-project-makefile"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">THE PROJECT MAKEFILE</h1>
<p>The installed Makefile is self-configuring. It can derive everything
from <code>MODULE_NAME</code> or the package name inside a custom stub file.</p>
<pre><code>MODULE_PATH  - lib/My/New/Module.pm (from MODULE_NAME)
PROJECT_NAME - My-New-Module (from MODULE_NAME)
TARBALL      - My-New-Module-1.0.0.tar.gz (from PROJECT_NAME + VERSION)
</code></pre>
<p>If <code>MODULE_NAME</code> is not supplied on the command line, it is inferred
from the project directory name.</p>
<p>Key Makefile targets:</p>
<ul>
<li>
<p><code>make</code> / <code>make all</code></p>
<p>Builds the distribution tarball. Generates <code>requires</code>,
<code>test-requires</code>, and <code>README.md</code> as prerequisites.</p>
</li>
<li>
<p><code>make bash-completion</code></p>
<p>Generates and installs a bash completion function for your project's
modulino, then prints the <code>source</code> line to enable it. The function is
produced by <code>&lt;modulino&gt; -generate-completion</code> (available to any
<code>CLI::Simple</code>-based modulino) and written to
<code>~/.local/share/bash-completion/completions/&lt;alias&gt;</code>.</p>
<pre><code>  make bash-completion
  # then, as it instructs:
  source ~/.local/share/bash-completion/completions/&lt;alias&gt;
</code></pre>
<p>The target depends on the modulino, so it will build <code>bin/&lt;alias&gt;</code>
first if needed. Completion is only available for modulinos that
subclass <code>CLI::Simple</code>.</p>
</li>
<li>
<p><code>make requires</code> / <code>make test-requires</code></p>
<p>Scans source files with <code>scandeps-static.pl</code> and writes the dependency
files specified in the <code>buildspec.yml</code> file used by <code>make-cpan-dist.pl</code>.</p>
<p><em>Note: By default, any change to your <code>.pm.in</code> files will trigger a
rescan of your modules for new dependencies. This will add a
significant delay when you have many modules and a large number of
dependencies. You can avoid the scan by setting the environment
variable <code>SCAN</code> to any value other than <code>ON</code> (case insensitive).</em></p>
<pre><code>  make SCAN=OFF
</code></pre>
</li>
<li>
<p><code>make recommends</code> / <code>make suggests</code></p>
<p>Companion targets to <code>make requires</code>. The dependency scanner classifies
each discovered module into one of three tiers: hard <code>requires</code>,
<code>recommends</code> (soft, non-eval conditional dependencies), and <code>suggests</code>
(eval-wrapped, optional dependencies). These populate the corresponding
sections of the generated <code>Makefile.PL</code>. Each is regenerated when a
source file changes; see <a href="#dependencies-management">"Dependencies Management"</a>.</p>
</li>
<li>
<p><code>make package</code></p>
<p>Runs the quality and dependency gates together (<code>lint</code> plus a
dependency scan) — a convenience for pre-release verification.</p>
</li>
<li>
<p><code>make release</code> / <code>make minor</code> / <code>make major</code></p>
<p>Bumps the patch, minor, or major version number in <code>VERSION</code>.</p>
</li>
<li>
<p><code>make release-notes</code></p>
<p>Generates a diff, file list, and tarball comparing the current version
to the previous git tag.</p>
</li>
<li>
<p><code>make clean</code></p>
<p>Removes generated files. Does not affect <code>buildspec.yml</code>, <code>VERSION</code>,
or any <code>*.in</code> source files.</p>
<p>If your project needs to add a project specific clean recipe, use the
<code>clean-local</code> target with a double-colon.</p>
<pre><code>  clean-local::
         rm -rf workdir
</code></pre>
</li>
<li>
<p><code>make tidy</code></p>
<p>Runs <code>perltidy</code> on all <code>.pm.in</code> and <code>.pl.in</code> source files using
the profile specified by <code>perltidyrc</code> in your config. Requires
<code>perltidyrc</code> to be set.</p>
</li>
<li>
<p><code>make critic</code></p>
<p>Runs <code>perlcritic</code> on all source files using the profile specified by
<code>perlcriticrc</code> in your config. Requires <code>perlcriticrc</code> to be set.</p>
</li>
<li>
<p><code>make lint</code></p>
<p>Runs both <code>make tidy</code> and <code>make critic</code>.</p>
</li>
<li>
<p><code>make git</code></p>
<p>Initializes a git repository, stages all recommended project files
including <code>.includes/*</code>, and makes an initial <code>BigBang</code> commit.</p>
</li>
<li>
<p><code>make quick</code></p>
<p>Builds the distribution tarball with dependency scanning and all
linting disabled. Useful during active development when you want fast
iterative builds without waiting for <code>scandeps-static.pl</code> or quality
gates.</p>
<pre><code>  make quick
</code></pre>
<p>Equivalent to:</p>
<pre><code>  make SCAN=off LINT=off
</code></pre>
</li>
<li>
<p><code>make workflow</code></p>
<p>Installs a CI build script (<code>builder</code>) and a GitHub Actions workflow
(<code>.github/workflows/build.yml</code>) into your project, templated with
your module and project name. Also merges any build-only dependencies
<code>builder</code> needs into <code>build-requires</code>.</p>
<pre><code>  make workflow
  git add build-requires builder .github/workflows/build.yml
</code></pre>
<p>Commit these files - GitHub Actions will then run <code>./builder</code> on
every push to <code>main</code> or <code>dev</code>. See <a href="#continuous-integration">"Continuous Integration"</a> for
what <code>builder</code> does and how to run it outside of GitHub Actions.</p>
</li>
<li>
<p><code>make build-ci</code></p>
<p>Runs <code>builder</code> locally inside Docker, against your current branch,
to reproduce a CI build without pushing. Requires <code>docker</code> and a
<code>builder</code> script (run <code>make workflow</code> first if you don't have one).</p>
<pre><code>  make build-ci
</code></pre>
<p>See <a href="#continuous-integration">"Continuous Integration"</a> for the variables that control this
target.</p>
</li>
</ul>
<a id="readmemd" class="anchor" aria-label="Permalink: README.md" href="#readmemd"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">README.md</h2>
<p>The <code>Makefile</code> will automatically create a <code>README.md</code> from your
Perl module's pod. The stock <code>buildspec.yml</code> will include that
<code>README.md</code> in the distribution's share directory. If you want the
<code>README.md</code> to be included in the distribution but not installed,
edit the <code>buildspec.yml</code> file.</p>
<p><strong>Before</strong></p>
<pre><code>extra-files:
  - ChangeLog
  - share:
    - README.md
</code></pre>
<p><strong>After</strong>
extra-files:
- ChangeLog
- README.md</p>
<p>If you want a different <code>README.md</code> generated create a
<code>README.md.in</code> file. That file will be filtered through
<code>md-utils.pl</code> (from <a href="https://metacpan.org/pod/Markdown%3A%3ARender" rel="nofollow">Markdown::Render</a>) to produce a <code>.md</code> file.</p>
<a id="commands" class="anchor" aria-label="Permalink: COMMANDS" href="#commands"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">COMMANDS</h1>
<ul>
<li>
<p>install (default)</p>
<p>Scaffolds a new project. This is the default command so:</p>
<pre><code>  cmb -m My::Module
</code></pre>
<p>...is the same as:</p>
<pre><code>  cmb -m My::Module install
</code></pre>
</li>
<li>
<p>create-config</p>
<p>Outputs a stub configuration file to STDOUT. Create and edit a new
config to customize the behavior of <code>cmb</code>.</p>
<pre><code>  cmb create-config &gt; ~/.cpan-makerrc
</code></pre>
<p>Then set <code>CPAN_MAKER_CONFIG</code> to point to it:</p>
<pre><code>  export CPAN_MAKER_CONFIG=$HOME/.cpan-makerrc
</code></pre>
</li>
<li>
<p>extra-files</p>
<pre><code>  cmb extra-files path file ...
</code></pre>
<p>Add files to be installed with the distribution. Use '.' for path if the file is to be installed in the root of the distribution tarball but not in the share directory. Use 'share' if the file is to be installed int the distribution share directory.</p>
<p><em>NOTE: file should be the relative path within the project that points to the file.</em></p>
<p>Example:</p>
<pre><code>  cmb extra-files . README.md
  cmb extra-files share share/config.json 
</code></pre>
</li>
<li>
<p>create-deps</p>
<pre><code>  cmb create-deps [module.pm.in ...]
</code></pre>
<p>Emits GNU make dependency rules (to STDOUT) capturing the
<strong>inter-module</strong> dependencies within your distribution -- i.e. which of
your own <code>.pm</code> files <code>use</code> which others. Uses
<a href="https://metacpan.org/pod/Module%3A%3AScanDeps%3A%3AStatic" rel="nofollow">Module::ScanDeps::Static</a> to scan each source module, then prints
<code>target: prerequisite</code> lines (in <code>deps.mk</code> form) for the internal
packages only, so <code>make</code> rebuilds a dependent module when a module it
depends on changes. With no arguments every project module is scanned;
name one or more modules to restrict the output.</p>
</li>
<li>
<p>critique</p>
<pre><code>  cmb critique file ...
  cmb critique --file-list manifest
</code></pre>
<p>Runs <a href="https://metacpan.org/pod/Perl%3A%3ACritic" rel="nofollow">Perl::Critic</a> over the given files (or a newline-delimited
<code>--file-list</code>). Defaults to the <code>pbp</code> theme at severity 5; override
with the <code>PERLCRITIC_THEME</code>, <code>PERLCRITIC_SEVERITY</code>, and
<code>PERLCRITICRC</code> environment variables. Requires <a href="https://metacpan.org/pod/Perl%3A%3ACritic" rel="nofollow">Perl::Critic</a> to be
installed.</p>
</li>
</ul>
<a id="llm-commands" class="anchor" aria-label="Permalink: LLM Commands" href="#llm-commands"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">LLM Commands</h2>
<p>The following commands require <a href="https://metacpan.org/pod/LLM%3A%3AAPI" rel="nofollow">LLM::API</a> to be installed and a valid
Anthropic API key. Set it in the environment before running any LLM command:</p>
<pre><code>export LLM_API_KEY=$(cat ~/.ssh/anthropic-api-key)
</code></pre>
<p>The key is deleted from the environment immediately after being read and
is never passed to child processes. See <a href="https://metacpan.org/pod/CPAN%3A%3AMaker%3A%3AConfigReader" rel="nofollow">CPAN::Maker::ConfigReader</a> for
the <code>llm-api-key-helper</code> option which avoids exposing the key in shell
history entirely.</p>
<p><em>SECURITY NOTE: Never pass your API key on the command line where it
would be visible in shell history and process listings.</em></p>
<ul>
<li>
<p>code-review</p>
<p>Submits a Perl module or script to the LLM for a code review. POD is
automatically stripped before submission so token costs reflect code
only. The review is written as a JSON file to the current directory.</p>
<pre><code>  cmb code-review [options] lib/My/Module.pm
</code></pre>
<p>The review file is named:</p>
<pre><code>  &lt;module&gt;-review-&lt;timestamp&gt;.code
</code></pre>
<p>A token usage summary is printed to stderr after the review completes.</p>
<p>If a review has been completed at least once the annotated review file
is automatically sent with your code to re-focus the review. You must
annotate the review file before resubmitting by running the
<code>annotate</code> command and marking each finding with a valid
dispostion. See <a href="#the-review-workflow">"THE REVIEW WORKFLOW"</a> for details.</p>
<p>Options specific to code-review:</p>
<pre><code>  --prompt|-p PATH          path to a custom review prompt file
  --prompt-profile|-P NAME  additive prompt profile (repeatable)
  --context|-C PATH         context file to submit alongside the review (repeatable)
</code></pre>
<p><em>Note: The prompt profile list and the context file list is written
to the review output file. On subsequent runs these will be read from
the review. You do not need to provide them unless you want to update
their values.</em></p>
</li>
<li>
<p>annotate</p>
<p>Applies disposition tags to findings in the latest review file and
displays the current annotation state. Must be run from a project
directory (one containing <code>.includes/</code>).</p>
<pre><code>  cmb annotate [options] lib/My/Module.pm
</code></pre>
<p>Without options, displays the current annotation state of the latest
review file. With <code>-a</code> options, applies the specified dispositions
before displaying.</p>
<pre><code>  cmb annotate lib/My/Module.pm
  cmb annotate -a 1:wrong -a 2:reject lib/My/Module.pm
</code></pre>
<p>Options:</p>
<pre><code>  --annotate|-a N:DISPOSITION    apply disposition to finding N (repeatable)
  --auto-annotate|-A             annotate and immediately submit the next review
  --finalize-annotations|-F      create versioned release artifact
</code></pre>
<p>Valid dispositions are <code>accept</code>, <code>reject</code>, <code>wrong</code>,
<code>wrong-reconsider</code>, <code>defer</code>, and <code>confirmed</code> (case
insensitive). See <a href="#the-review-workflow">"THE REVIEW WORKFLOW"</a> for a description of each.</p>
</li>
<li>
<p>pod-finding</p>
<pre><code>  cmb pod-finding lib/CPAN/Maker/Bootstrapper.pm
</code></pre>
<p>Run this after a <code>pod-review</code> command to display a table of findings.</p>
</li>
<li>
<p>pod-review</p>
<p>Submits a Perl module or script to the LLM for a documentation review.
The full file including code is submitted so the LLM can check
consistency between implementation and documentation. If no POD exists
the LLM generates complete POD documentation ready to paste after
<code>__END__</code>.</p>
<pre><code>  cmb pod-review lib/My/Module.pm
</code></pre>
<p>The review file is named:</p>
<pre><code>  &lt;module&gt;-review-&lt;timestamp&gt;.pod
</code></pre>
</li>
<li>
<p>release-notes</p>
<p>Generates release notes for a given version using the LLM. Requires
the release artifacts produced by <code>make release-notes</code>:</p>
<pre><code>  release-&lt;version&gt;.diffs
  release-&lt;version&gt;.lst
  release-&lt;version&gt;.tar.gz

  cmb release-notes &lt;version&gt;
</code></pre>
<p>The generated release notes are written to <code>release-notes-&lt;version&gt;.md</code>.
Binary files are automatically excluded. Use <code>--max-diff-files</code> to
cap token consumption on large distributions (default: 50, 0 = unlimited).</p>
</li>
<li>
<p>code-finding</p>
<p>Generates a table with the complete details of a finding.</p>
<pre><code>  cmb code-finding lib/My/Module.pm 1
</code></pre>
</li>
<li>
<p>update-annotations</p>
<pre><code>  cmb update-annotations file
</code></pre>
<p>Applies human-curated annotations to the most recent code review for
<code>file</code>. On first run it generates an <code>.annotate</code> file alongside the
review for you to edit; re-run it to apply your edited annotations back
into the review. Pairs with <code>code-review</code>/<code>annotate</code> in the review
workflow.</p>
</li>
</ul>
<a id="options" class="anchor" aria-label="Permalink: OPTIONS" href="#options"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">OPTIONS</h1>
<ul>
<li>
<p><code>--annotate|-a</code> N:DISPOSITION</p>
<p>See <a href="#annotate">"annotate"</a></p>
</li>
<li>
<p><code>--auto-annotate|-A</code></p>
<p>See <a href="#annotate">"annotate"</a></p>
</li>
<li>
<p><code>--basedir|-b</code> DIR</p>
<p>Base directory in which to create the projects. Defaults to the
current working directory when <code>--installdir</code> and <code>--basedir</code> are not
provided. The directory must exist or the script will throw an
exception.</p>
<p><em>Note: If <code>--installdir</code> is provided it takes precedence and
<code>--basedir</code> is ignored.</em></p>
<p>default: pwd</p>
</li>
<li>
<p><code>--color|--no-color</code></p>
<p>default: color</p>
<p>To turn color off use --no-color.</p>
</li>
<li>
<p><code>--dry-run|-D</code></p>
<p>Dry run mode will abort after displaying a pre-submission token and
cost estimation for the <code>pod-review</code> and <code>code-review</code> commands.</p>
</li>
<li>
<p><code>--config|-c</code> configuration file</p>
<p>The path to a <code>.ini</code> file that contains configuration information
used to scaffold your project.</p>
<p>default: ~/.gitconfig</p>
</li>
<li>
<p><code>--color, --no-color</code></p>
<p>Turns coloring of the annotation summary table on or off.</p>
<p>default: on</p>
</li>
<li>
<p><code>--context|-C</code> PATH</p>
<p>One or more files to submit with your code review file that provide
additional context for the LLM during the review.</p>
</li>
<li>
<p><code>--email|-e</code> EMAIL</p>
<p>Override the author email. Defaults to <code>user.email</code> from your global
git config.</p>
</li>
<li>
<p><code>--finalize-annotations|-F</code></p>
<p>See <a href="#annotate">"annotate"</a></p>
</li>
<li>
<p><code>--force|-f</code></p>
<p>Overwrite an existing project. Without this flag, the command dies if a
<code>Makefile</code> already exists in the target directory.</p>
</li>
<li>
<p><code>--github-user|-g</code> USER</p>
<p>Override the GitHub username used to construct repository URLs in
<code>buildspec.yml</code>. Defaults to <code>user.github</code> from your global git config.</p>
</li>
<li>
<p><code>--import|-I</code> path</p>
<p>A path that contains <code>.pm</code> or <code>.pl</code> files for importing into the
project. You can specify multiple paths. You cannot use <code>--stub</code> and
<code>--import</code> together.</p>
<p>Example:</p>
<pre><code>  cmb --module Foo::Bar -I ~/foo-bar/lib -I ~/foo-bar/bin
</code></pre>
<p>When using the <code>--import</code> option, you must use the <code>--module</code> option
to specify the primary module name of the distribution. The importer
cannot infer the module name from the imported files alone.</p>
<p><em>Note: The <code>Makefile</code> will automatically attempt to substitute the
token <code>@PACKAGE_VERSION@</code> inside your <code>.pl.in</code> or <code>.pm.in</code> files with
the current semantic version in the <code>VERSION</code> file. If you want to
use that for versioning your scripts and modules add the token as
shown below:</em></p>
<p><code>our $VERSION = '@PACKAGE_VERSION@;'</code></p>
</li>
<li>
<p><code>--installdir|-i</code> DIR</p>
<p>Directory in which to create the project. Defaults to the
current working directory. The directory is created if it does not
exist.</p>
<p>Example:</p>
<pre><code>  cmb --installdir ~/git/My-Module
</code></pre>
<p>The install directory should include the project name.</p>
<p><em>Note: <code>--installdir</code> overrides <code>--basedir</code></em>.</p>
</li>
<li>
<p><code>--max-diff-files</code> LIMIT</p>
<p>The number of files inside the tarball that contains the changed files
for release notes creation that can be uploaded to the LLM. Set to 0
for no limit.</p>
<p>default: 50</p>
</li>
<li>
<p><code>--max-tokens|-t</code> TOKENS</p>
<p>Maximum number of tokens the LLM may return in a single response.
Higher values reduce the risk of truncated reviews on large files.</p>
<p>default: 4096 (set by <a href="https://metacpan.org/pod/LLM%3A%3AAPI" rel="nofollow">LLM::API</a>)</p>
</li>
<li>
<p><code>--model|-M</code> MODEL</p>
<p>Specifies the model id to use for the <code>pod-review</code> and <code>code-review</code>
commands.</p>
<p>For <code>pod-review</code> the default model is <code>claude-haiku-4-5-20251001</code>.</p>
<p>For <code>code-review</code> the default mode is <code>claude-sonnet-4-6</code>.</p>
<p>The Haiku model tends to be better at summarizing documentation and
avoiding unnecessary analysis around edge cases that contribute to
noise.</p>
<p><em>Caution: Both models try hard to find issues to the point that you
will almost never get a clean run when asking for a POD review. When
your POD is complete, accurate and usable it's good enough. Avoid
shaving the yak!</em></p>
</li>
<li>
<p><code>--module|-m</code> MODULE (required)</p>
<p>The Perl module name for the new project, e.g. <code>My::New::Module</code>.
Used to derive the project directory name, source file path, and
tarball name. You can omit this option if you provide a stub file
(<code>--stub path</code>) that contains a package name that is consistent with
the stub's path. For example, if my package is <code>My::App</code> and the
module path contains <code>My/App</code> then the script will assume your
module name is <code>My::App</code>.</p>
<pre><code>  cmb --stub $HOME/workdir/My/App.pm
</code></pre>
</li>
<li>
<p><code>--prompt|-p</code> PATH</p>
<p>Path to a text file that will be used to prompt the LLM for a code or pod review.</p>
<p>defaults:</p>
<pre><code>  pod  =&gt; .prompts/pod-review.prompt
  code =&gt; .prompts/code-review.prompt
</code></pre>
</li>
<li>
<p><code>--prompt-profile|-P</code> NAME</p>
<p>The name of a prompt profile located in the <code>.prompts</code> directory. One
or more profile names may be specified. You need only provide the name
(e.g. cli-tool).</p>
<p>See <a href="#prompt-profiles">"PROMPT PROFILES"</a></p>
</li>
<li>
<p><code>--resources|-r</code> github</p>
<p>Currently takes only a single value: 'github' that indicates that the
resources section of <code>Makefile.PL</code> should be populated with GitHub
URL references. Future versions may support additional providers.</p>
</li>
<li>
<p><code>--stub|-s</code> TYPE|PATH</p>
<p>Controls the module stub used to generate the initial <code>.pm.in</code> source
file. Three forms are accepted:</p>
<ul>
<li>Omitted - uses the default plain class stub (<code>class-module.pm.tmpl</code>).</li>
<li>
<code>cli</code> - uses the CLI stub (<code>cli-module.pm.tmpl</code>), which
inherits from <a href="https://metacpan.org/pod/CLI%3A%3ASimple" rel="nofollow">CLI::Simple</a> and includes a skeleton <code>main</code>, <code>init</code>,
and a placeholder command.</li>
<li>A file path - uses the specified file as the stub. The file
must exist or the command will die with an error. This allows you to
supply your own template or bootstrap a project around a module you
have already started writing. You can omit the <code>--module</code> option if
you supply your own stub file. See the explanation for the
<code>--module</code> option for details.</li>
</ul>
<p>When specifying a stub you cannot use the <code>--import</code> option.</p>
</li>
<li>
<p><code>--username|-u</code> NAME</p>
<p>Override the author name used in the module stub and <code>buildspec.yml</code>.
Defaults to <code>user.name</code> from your global git config.</p>
</li>
</ul>
<a id="the-review-workflow" class="anchor" aria-label="Permalink: THE REVIEW WORKFLOW" href="#the-review-workflow"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">THE REVIEW WORKFLOW</h1>
<p><code>CPAN::Maker::Bootstrapper</code> allow you implement a structured
iterative code review workflow built around JSON review files and
developer-applied disposition annotations. The workflow converges over
several rounds, with each round potentially costing less as noise is
suppressed and findings are resolved.</p>
<a id="overview" class="anchor" aria-label="Permalink: Overview" href="#overview"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Overview</h2>
<p>Each review round consists of three steps:</p>
<ul>
<li>
<ol>
<li>
<p>Run a review</p>
<p>cmb code-review --prompt-profile cli-tool lib/My/Module.pm</p>
</li>
</ol>
<p>The review is written to a timestamped <code>.code</code> file containing a JSON
object with <code>findings</code>, <code>confirmations</code>, and <code>deferred</code> arrays.</p>
</li>
<li>
<ol start="2">
<li>Annotate the findings</li>
</ol>
<p>An annotation is how you mark a finding with a disposition. The
dispositions are used by the LLM during thenext review. See <a href="#dispositions">"Dispositions"</a>.</p>
<pre><code>  cmb annotate lib/My/Module.pm
</code></pre>
<p>This displays the current annotation state. Apply dispositions with
<code>-a</code> options:</p>
<pre><code>  cmb annotate -a 1:accept -a 2:wrong -a 3:reject -a 4:defer lib/My/Module.pm
</code></pre>
<p>You can annotate incrementally across multiple invocations. Each call
shows the updated state so you always know what remains.</p>
</li>
<li>
<ol start="3">
<li>Submit the next review</li>
</ol>
<p>Once all findings are annotated and code updated if necessary, run the
next review. The bootstrapper automatically finds and submits the
latest annotated review file with your updated code:</p>
<pre><code>  cmb code-review lib/My/Module.pm
</code></pre>
<p>Alternatively, use <code>--auto-annotate|-A</code> with the <code>annotate</code> command
to annotate and immediately resubmit in one step:</p>
<pre><code>  cmb annotate -a 1:wrong -a 2:reject --auto-annotate \
    lib/My/Module.pm
</code></pre>
<p>The LLM will honor all dispositions from the prior round, confirm
fixes marked <code>ACCEPT</code>, carry forward <code>DEFER</code> items, and suppress
<code>REJECT</code> and <code>WRONG</code> findings. New findings appear without noise
from settled questions.</p>
</li>
</ul>
<a id="dry-run-mode" class="anchor" aria-label="Permalink: Dry Run Mode" href="#dry-run-mode"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Dry Run Mode</h2>
<p>Before your prompt and code are submitted for review, the script will
output a table of showing you the estimated cosst based on token
counts. The input token count is derived by calling the "COUNT TOKEN"
endpoint API with the message to be submitted for review. The input
token count is therefore accurate, while the output token count is an
estimate.</p>
<p>To stop the script for actually submitting the message for review, use
the <code>--dry-run</code> option. This will abort the process immediately prior
to submission.</p>
<a id="dispositions" class="anchor" aria-label="Permalink: Dispositions" href="#dispositions"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Dispositions</h2>
<p>Each finding in the annotations file must be given one of the
dispositions describe below before the next review can be
submitted. The prompt sent to the LLM is designed around these
dispositions. This helps the LLM produce findings that hopefully will
converge on a clean review.</p>
<ul>
<li>
<p>ACCEPT</p>
<p>The finding is valid and has been fixed. On the next review the LLM
will confirm the fix is present. If the fix is not found the finding
will be re-raised.</p>
</li>
<li>
<p>REJECT</p>
<p>The finding has been reviewed and dismissed as inapplicable to this
codebase or context. It will not be raised again in subsequent reviews.</p>
</li>
<li>
<p>WRONG</p>
<p>The finding was based on faulty reasoning. The code is correct. The
finding will not be re-raised. Use this when the LLM has misread the
control flow, misunderstood the design intent, or applied an
inappropriate threat model.</p>
</li>
<li>
<p>WRONG-RECONSIDER</p>
<p>Applied automatically at finalization to all findings marked WRONG.
On the first review of the next version the LLM will re-examine the
specific function and code excerpt carefully. If the prior analysis
was still incorrect the finding reverts to WRONG. If the code has
changed and the finding is now valid it is raised as a new finding.
If the model understands specifically why its prior reasoning was
wrong it may mark the finding CONFIRMED.</p>
</li>
<li>
<p>DEFER</p>
<p>The finding is known and acknowledged but not yet addressed. It is
carried forward in the <code>deferred</code> array of each subsequent review
without being treated as a new finding.</p>
</li>
<li>
<p>CONFIRMED</p>
<p>Used for logic confirmations rather than defects. Marks that both the
LLM and the developer agree the code is correct.</p>
</li>
</ul>
<a id="diminishing-returns-and-when-to-stop" class="anchor" aria-label="Permalink: Diminishing Returns and When to Stop" href="#diminishing-returns-and-when-to-stop"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Diminishing Returns and When to Stop</h2>
<p>Run the <code>annotate</code> command after each review submission to view the
findings. Each round tends to surface smaller and more obscure issues
as obvious findings are resolved. Despite some fairly aggressive
attempts to create prompts that prevent trivial or obscure findings
you should stop when you see these signals:</p>
<ul>
<li>All new findings are LOW severity.</li>
<li>The LLM is re-raising findings already marked WRONG or REJECT,
possibly rephrased (LLMs can and do make mistakes!).</li>
<li>New findings describe edge cases that cannot occur in normal usage.</li>
</ul>
<p>When all findings have dispositions and no new substantive issues
appear, the code is ready to ship.</p>
<a id="the-release-artifact" class="anchor" aria-label="Permalink: The Release Artifact" href="#the-release-artifact"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">The Release Artifact</h2>
<p>When you are satisfied with the review state, finalize it with
<code>--finalize-annotations</code>:</p>
<pre><code>cmb annotate --finalize-annotations -a 1:wrong -a 2:reject lib/My/Module.pm
</code></pre>
<p>This applies any remaining dispositions, validates that all findings
are annotated, reads the version from the <code>VERSION</code> file, and writes
the versioned release artifact:</p>
<pre><code>CPAN-Maker-Bootstrapper-1.1.0-REVIEW.json
</code></pre>
<p>This file serves as a code review certification for the release - a
machine-readable record of every finding examined, every logic
confirmation made, and every disposition applied before the version
was published. Commit it to the repository alongside your ChangeLog.</p>
<p>All findings marked WRONG are automatically converted to
WRONG-RECONSIDER in the release artifact, prompting careful
re-examination on the first review of the next version rather
than permanent suppression.</p>
<a id="cost-management" class="anchor" aria-label="Permalink: Cost Management" href="#cost-management"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Cost Management</h2>
<p>Typical review costs run $0.05-0.10 per run on a moderately sized
module with POD stripped depending on the model you choose. The
default model used for POD review is <code>claude-haiku-4-5-20251001</code> and
<code>claude-sonnet-4-6</code> for code review. Costs decrease over successive
rounds as the model spends fewer output tokens re-explaining
suppressed findings.</p>
<p>Use your own prompt profiles (<code>--prompt-profile</code>) to suppress entire
classes of noise before they reach the annotation file. A well-tuned
profile for your application type is the highest-leverage cost
reduction available.</p>
<a id="see-also" class="anchor" aria-label="Permalink: See Also" href="#see-also"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">See Also</h2>
<p><a href="#llm-commands">"LLM Commands"</a>, <a href="#prompt-profiles">"PROMPT PROFILES"</a>, <a href="https://metacpan.org/pod/CPAN%3A%3AMaker%3A%3AConfigReader" rel="nofollow">CPAN::Maker::ConfigReader</a></p>
<a id="prompt-profiles" class="anchor" aria-label="Permalink: PROMPT PROFILES" href="#prompt-profiles"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">PROMPT PROFILES</h1>
<p>Prompt profiles are additive prompt fragments that customize the review
behavior for specific application types. They are appended to the base
review prompt before submission and are intended to focus the review on
relevant concerns while suppressing noise that does not apply to the
target context.</p>
<p><em>NOTE: Prompts count toward your input token count. Be succinct and
accurate.</em></p>
<a id="using-profiles" class="anchor" aria-label="Permalink: Using Profiles" href="#using-profiles"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Using Profiles</h2>
<p>Pass one or more profiles using the <code>--prompt-profile</code> option:</p>
<pre><code>cmb code-review --prompt-profile cli-tool MyModule.pm
</code></pre>
<p>Multiple profiles may be combined:</p>
<pre><code>cmb code-review --prompt-profile cli-tool --prompt-profile security MyModule.pm
</code></pre>
<p>Profiles are resolved from the <code>.prompts/</code> directory in the current
project. A profile named <code>cli-tool</code> resolves to
<code>.prompts/cli-tool.prompt</code>. Add your own prompt profiles and commit
them to your project.</p>
<a id="built-in-profiles" class="anchor" aria-label="Permalink: Built-in Profiles" href="#built-in-profiles"><span aria-hidden="true" class="octicon octicon-link"></span></a><h3 class="heading-element">Built-in Profiles</h3>
<p>The following profile is installed with the distribution:</p>
<ul>
<li>
<p>cli-tool</p>
<p>Appropriate for single-user developer CLI tools. Suppresses security
findings that assume a multi-user or hostile environment, TOCTOU race
condition findings that assume concurrent invocation, and concerns about
<code>qx{}</code> or <code>system()</code> calls where input originates from the user's own
configuration. Also assumes <code>perlcritic</code> and <code>perltidy</code> are enforced
in the development environment.</p>
</li>
</ul>
<a id="creating-custom-profiles" class="anchor" aria-label="Permalink: Creating Custom Profiles" href="#creating-custom-profiles"><span aria-hidden="true" class="octicon octicon-link"></span></a><h3 class="heading-element">Creating Custom Profiles</h3>
<p>A profile is a plain text file in <code>.prompts/</code> containing additional
prompt instructions, one per line. Lines beginning with <code>#</code> are treated
as comments and stripped before submission. Profile instructions use the
same format as the base review prompt.</p>
<p>Example <code>.prompts/security.prompt</code>:</p>
<pre><code># security profile - add to any review where input handling matters
- Treat all caller-supplied input as untrusted regardless of source.
- Flag any use of eval, system, or exec that incorporates external data.
- Flag missing taint checks on data used in file or system operations.
</code></pre>
<a id="planned-profiles" class="anchor" aria-label="Permalink: Planned Profiles" href="#planned-profiles"><span aria-hidden="true" class="octicon octicon-link"></span></a><h3 class="heading-element">Planned Profiles</h3>
<p>The following profiles are planned for future releases:</p>
<ul>
<li>
<p>library</p>
<p>Focuses on API contract correctness and caller assumptions. Appropriate
for CPAN distributions intended for use by unknown callers.</p>
</li>
<li>
<p>web-application</p>
<p>Treats external input as untrusted. Flags injection risks, authentication
gaps, and session handling concerns.</p>
</li>
<li>
<p>mod-perl-handler</p>
<p>Addresses Apache lifecycle concerns including global state, startup versus
request time initialization, and child process behavior.</p>
</li>
<li>
<p>lambda-function</p>
<p>Focuses on cold start performance, statelessness, and environment variable
handling appropriate for AWS Lambda deployments.</p>
</li>
</ul>
<p>Community contributions of additional profiles are welcome. See
<a href="https://github.com/rlauer6/CPAN-Maker-Bootstrapper/issues">https://github.com/rlauer6/CPAN-Maker-Bootstrapper/issues</a>.</p>
<a id="extending-the-build-system" class="anchor" aria-label="Permalink: EXTENDING THE BUILD SYSTEM" href="#extending-the-build-system"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">EXTENDING THE BUILD SYSTEM</h1>
<p>The bootstrapper's <code>Makefile</code> is intended to be immutable and work
across all of the projects that use <code>CPAN::Maker::Bootstrapper</code>. Our
goal is to keep <code>Makefile</code> working for you even when we make updates
to the bootstrapper.</p>
<p>However, you own <code>Makefile</code> and are free to do with it as you
please. But we strongly advise that you read the sections below and
follow the <em>recipe</em> as the saying goes, to use and update the build
system as it was intended.</p>
<p>The installed <code>Makefile</code> is a managed file - it can be updated by
using the <code>make</code> target <code>update</code> when a new version of
<code>CPAN::Maker::Bootstrapper</code> is released.</p>
<pre><code>make update
</code></pre>
<p>You are strongly advised not to modify the <code>Makefile</code> - your changes
will be overwritten if you run <code>make update</code>.</p>
<p>Instead, the recommended workflow, should you need to add new make
targets or control the order of the build based on dependencies is to
add those to <code>project.mk</code>. All managed build system files live in
the <code>.includes/</code> directory where they are write-protected and clearly
separated from your project files. The <code>Makefile</code> includes them
automatically and conditionally includes <code>project.mk</code> from the
project root:</p>
<pre><code>include .includes/perl.mk
include .includes/help.mk
include .includes/version.mk
include .includes/release-notes.mk
include .includes/git.mk
include .includes/update.mk
include .includes/upgrade.mk
-include project.mk
</code></pre>
<p><code>project.mk</code> remains in the project root - it is your file, always
writable, and never touched by <code>make update</code>. The leading <code>-</code> on
its include means make will not complain if it does not exist yet.
This gives you a sanctioned, upgrade-safe extension point for
anything project-specific.</p>
<a id="how-the-makefile-works" class="anchor" aria-label="Permalink: How the Makefile Works" href="#how-the-makefile-works"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">How the Makefile Works</h2>
<p>The installed <code>Makefile</code> is structured around a few key concepts:</p>
<ul>
<li>
<strong>Source files</strong> live in <code>lib/</code> as <code>.pm.in</code> and in <code>bin/</code> as
<code>.pl.in</code>. The build generates the final <code>.pm</code> and <code>.pl</code> files from
these sources by substituting <code>@PACKAGE_VERSIONE@</code> and other
tokens, running syntax checks, and optionally running perltidy and
perlcritic.</li>
<li>
<strong>Sentinel files</strong> - <code>.tdy</code> and <code>.crit</code> files track whether
a source file has passed tidiness and critic checks. These are
regenerated only when the source changes.</li>
<li>
<strong>Dependency scanning</strong> - <code>scandeps-static.pl</code> scans your
source files and generates <code>requires</code> and <code>test-requires</code> files
which feed into <code>Makefile.PL</code>. Controlled by <code>SCAN=on|off</code>.</li>
<li>
<strong>The distribution tarball</strong> is the final output of <code>make</code>.
It is built by <code>make-cpan-dist.pl</code> using <code>buildspec.yml</code>.</li>
</ul>
<p>Key variables you can override on the make command line or in
<code>project.mk</code>:</p>
<ul>
<li>
<code>SCAN=off</code> - skip dependency scanning</li>
<li>
<code>LINT=off</code> - skip perltidy and perlcritic</li>
<li>
<code>SYNTAX_CHECKING=off</code> - skip <code>perl -wc</code> syntax checks</li>
<li>
<code>MIN_PERL_VERSION=5.016</code> - minimum Perl version for Makefile.PL</li>
<li>
<code>PERLTIDYRC=/path/to/rc</code> - path to perltidy configuration</li>
<li>
<code>PERLCRITICRC=/path/to/rc</code> - path to perlcritic configuration</li>
<li>
<code>SKIP_TESTS=1</code> - interpreted by <a href="https://metacpan.org/pod/CPAN%3A%3AMaker" rel="nofollow">CPAN::Maker</a>; skips running
the test suite when building the distribution tarball</li>
<li>
<code>PERLWC_SKIP="file1 file2"</code>  - space-separated list of files
to exclude from syntax and POD checks</li>
<li>
<code>POD=extract|remove</code> - extract POD to a companion <code>.pod</code> file
or strip it entirely from the built <code>.pm</code>
</li>
<li>
<code>PERLINCLUDE="-I path"</code> - additional include paths used during
the <code>perl -wc</code> syntax check</li>
</ul>
<div class="markdown-heading"><h2 class="heading-element">What Belongs in <code>project.mk</code>
</h2><a id="what-belongs-in-projectmk" class="anchor" aria-label="Permalink: What Belongs in project.mk" href="#what-belongs-in-projectmk"><span aria-hidden="true" class="octicon octicon-link"></span></a></div>
<ul>
<li>
<p>Custom targets</p>
<p>Any target specific to your project - generating assets, running
linters, deploying, sending notifications:</p>
<pre><code>  .PHONY: deploy
  deploy: all
      scp $(TARBALL) user@myserver:/opt/cpan
</code></pre>
</li>
<li>
<p>Inter-module dependencies</p>
<p>If your modules have build-time dependencies on each other, declare
them here rather than modifying the Makefile:</p>
<pre><code>  lib/Foo/Bar.pm: lib/Foo.pm
</code></pre>
</li>
<li>
<p>Additional file generation</p>
<p>If your project generates code or configuration from templates beyond
what the standard Makefile handles:</p>
<pre><code>  lib/Foo/Generated.pm.in: schema/foo.json
      perl bin/generate-module.pl $&lt; &gt; $@
</code></pre>
</li>
<li>
<p>Project-specific variables</p>
<pre><code>  DEPLOY_HOST = myserver.example.com
  DEPLOY_PATH = /opt/cpan/incoming
</code></pre>
</li>
<li>
<p>Extending CLEANFILES</p>
<p>Add project-specific generated files to the cleanup target by
appending to <code>CLEANFILES</code>:</p>
<pre><code>  CLEANFILES += mygenerated.pm config/generated.yml
</code></pre>
</li>
<li>
<p>Extending the <code>clean-recipe</code></p>
<pre><code>  clean-local::
         rm -rf workd
</code></pre>
</li>
</ul>
<a id="what-does-not-belong-in-projectmk" class="anchor" aria-label="Permalink: What does NOT belong in project.mk" href="#what-does-not-belong-in-projectmk"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">What does NOT belong in project.mk</h2>
<ul>
<li>Modifications to existing targets like <code>all</code>, <code>clean</code>, <code>requires</code>
</li>
<li>Changes to <code>DEPS</code>, <code>CLEANFILES</code>, or other core variables - these
are owned by the managed Makefile</li>
<li>Anything that duplicates logic already in the managed Makefile</li>
</ul>
<a id="keeping-the-build-system-up-to-date" class="anchor" aria-label="Permalink: Keeping the build system up to date" href="#keeping-the-build-system-up-to-date"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Keeping the build system up to date</h2>
<p>The following targets manage the lifecycle of the build system itself:</p>
<ul>
<li>
<p><code>make check-upgrade</code> / <code>make upgrade-check</code></p>
<p>Checks MetaCPAN to see if a newer version of
<code>CPAN::Maker::Bootstrapper</code> is available.</p>
</li>
<li>
<p><code>make upgrade</code></p>
<p>Checks MetaCPAN, installs the latest version via <code>cpanm</code>, then
automatically runs <code>make update</code> to refresh the managed project
files.</p>
</li>
<li>
<p><code>make update</code></p>
<p>Copies the managed files from the currently installed bootstrapper
distribution into your project directory. After running, use
<code>git diff</code> to review what changed and <code>git checkout &lt;file&gt;</code>
to revert any changes you don't want.</p>
<p>The following files are managed and may be updated:</p>
<pre><code>  Makefile
  .includes/git.mk
  .includes/help.mk
  .includes/update.mk
  .includes/upgrade.mk
  .includes/version.mk
  .includes/perl.mk
  .includes/release-notes.mk
  modulino.tmpl
</code></pre>
<p>Your <code>project.mk</code>, <code>buildspec.yml</code>, <code>requires</code>, <code>VERSION</code>, source
files and tests are <strong>never</strong> touched by <code>make update</code>.</p>
</li>
<li>
<p><code>make cpanm</code></p>
<p>Installs <code>cpanminus</code> if it is not already available on your
<code>PATH</code>. Required for <code>make upgrade</code> to work:</p>
<pre><code>  make cpanm &amp;&amp; make upgrade
</code></pre>
</li>
</ul>
<a id="automatic-drift-and-update-checks" class="anchor" aria-label="Permalink: Automatic Drift and Update Checks" href="#automatic-drift-and-update-checks"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Automatic Drift and Update Checks</h2>
<p>Every build runs two checks before proceeding, so you don't have to
remember to run <code>make check-upgrade</code> yourself:</p>
<ul>
<li>Is a newer <code>CPAN::Maker::Bootstrapper</code> published on CPAN than the
one installed on this machine?</li>
<li>Do this project's managed files still match what the <em>currently
installed</em> <code>CPAN::Maker::Bootstrapper</code> would produce?</li>
</ul>
<p>These are independent questions - your installed bootstrapper can be
fully current while a given project has still drifted from it (most
commonly because the project hasn't been through <code>make update</code>
since you last upgraded), or your bootstrapper itself can be behind
CPAN while every project stays perfectly in sync with it.</p>
<p><em>Drift</em> can happen for either of two reasons: your installed
<code>CPAN::Maker::Bootstrapper</code> was upgraded since this project last ran
<code>make update</code>, or a managed file was hand-edited despite the
warnings not to (see <a href="#what-you-should-never-modify">"What You Should Never Modify"</a>). <code>make</code>
doesn't try to tell these apart - the fix is the same either way:</p>
<pre><code>make update
</code></pre>
<p>Two variables, set in <code>config.mk</code>, control how strict these checks
are:</p>
<ul>
<li>
<p><code>CMB_UPDATE_CHECK</code> (<code>on</code>|<code>off</code>, default <code>on</code>)</p>
<p>Set to <code>off</code> to skip the MetaCPAN lookup - useful in CI or offline
environments where the network call would just fail or slow things
down.</p>
</li>
<li>
<p><code>CMB_VERSION_DRIFT</code> (<code>fail</code>|<code>warn</code>|<code>ignore</code>, default <code>fail</code>)</p>
<p>Controls what happens when a project's managed files no longer match
the installed bootstrapper. <code>fail</code> stops the build until you run
<code>make update</code>; <code>warn</code> prints a message and continues; <code>ignore</code>
skips the check entirely.</p>
</li>
</ul>
<a id="what-you-should-never-modify" class="anchor" aria-label="Permalink: What You Should Never Modify" href="#what-you-should-never-modify"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">What You Should Never Modify</h2>
<p>The files in <code>.includes/</code> - <code>perl.mk</code>, <code>git.mk</code>, <code>help.mk</code> etc.
- are managed files that will be overwritten by <code>make update</code>. Do
not modify them directly. If you need to override behavior they
provide, do so in <code>project.mk</code> using Make's double-colon rule
pattern or by setting variables before the include.</p>
<p>The <code>Makefile</code> itself is also managed and will be overwritten by
<code>make update</code>. Your extension point is exclusively <code>project.mk</code>.</p>
<a id="dependencies-management" class="anchor" aria-label="Permalink: Dependencies Management" href="#dependencies-management"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Dependencies Management</h2>
<p>The <code>Makefile</code> will attempt to detect Perl module dependencies by
scanning .pm.in and .pl.in files and creating the <code>requires</code> and
<code>test-requires</code> files whenever you run <code>make</code>. These files are used
by the <code>make-cpan-dist.pl</code> utility to specify the dependencies in your
CPAN distribution file. You can prevent that by setting the environment
variable <code>SCAN=OFF</code>. The default is <code>SCAN=ON</code>.</p>
<p>To prevent an entry from being removed by a rescan, prefix the module
name with <code>+</code>. These entries are sticky and survive all subsequent
scans even if the scanner no longer detects them.  To pin a specific
version, simply edit the version number in the <code>requires</code> file. If
the scanner subsequently detects a different version, the Makefile
will preserve your pinned version. Note that pinned versions are
<strong>never</strong> updated automatically - if you want to adopt a newer version
you must edit the file manually.</p>
<p>In your requires file:</p>
<pre><code>+Foo::Bar 1.0    # sticky - survives all rescans
Baz::Qux  2.5   # version pinned - scanner won't override this version
</code></pre>
<p><em>Note: These two mechanisms are independent - <code>+</code> controls whether an entry
survives rescans, while the version number controls what version is
required.</em></p>
<a id="modulinos" class="anchor" aria-label="Permalink: MODULINOS" href="#modulinos"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">MODULINOS</h1>
<p>A modulino is a Perl module that doubles as a runnable script by
checking whether it was invoked directly or loaded as a library:</p>
<pre><code>package Foo::Bar;

caller or __PACKAGE__-&gt;main;

sub main {
  ...
  exit 0;
}
</code></pre>
<p>Modulinos are useful for CLI scripts because they encourage
encapsulation, simplify unit testing, and keep logic organized
in named methods rather than inline code.</p>
<p>The <code>Makefile</code> provides a <code>modulino</code> target that generates a bash
wrapper script that invokes your module. By default it uses
<code>MODULE_NAME</code>, producing a script named after the module:</p>
<pre><code>make modulino
</code></pre>
<p>For a project named <code>Foo::Bar</code> this creates <code>bin/foo-bar.in</code>.
<code>make</code> then builds <code>bin/foo-bar</code> from that source file via a
pattern rule, and the executable ends up in the distribution.</p>
<p>To create a modulino wrapper for a module other than the primary
project module, override <code>MODULE_NAME</code>:</p>
<pre><code>make modulino MODULE_NAME=Foo::Bar::Buz
</code></pre>
<p>This creates <code>bin/foo-bar-buz.in</code> invoking <code>Foo::Bar::Buz</code>.</p>
<p>To give the wrapper a short or memorable name independent of the
module name, set <code>ALIAS</code>:</p>
<pre><code>make modulino MODULE_NAME=Foo::Bar::Buz ALIAS=fbb
</code></pre>
<p>This creates <code>bin/fbb.in</code> which still invokes <code>Foo::Bar::Buz</code>.
<code>ALIAS</code> accepts either a plain name (<code>fbb</code>) or a module-style
name (<code>Foo::Bar::Buz</code>) - colons are converted to hyphens and
the result is lowercased.</p>
<p>The generated wrapper scripts (without the <code>.in</code> suffix) are
automatically added to <code>.gitignore</code> since they are build artifacts.
The <code>.in</code> source files are tracked by git.</p>
<a id="continuous-integration" class="anchor" aria-label="Permalink: Continuous Integration" href="#continuous-integration"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Continuous Integration</h2>
<p><code>make workflow</code> installs <code>builder</code>, a self-contained bash script
that performs a clean-room build: it installs a minimal Perl
toolchain, installs your distribution's dependencies, and runs
<code>make</code>. It's designed to run unmodified in GitHub Actions, in any
other CI runner, or by hand from the command line.</p>
<a id="running-builder-manually" class="anchor" aria-label="Permalink: Running builder manually" href="#running-builder-manually"><span aria-hidden="true" class="octicon octicon-link"></span></a><h3 class="heading-element">Running builder manually</h3>
<p><code>builder</code> can build any git repository, not just the one it's
installed in - useful for testing a build in isolation without
touching your working tree:</p>
<pre><code>docker run --rm -v "$(pwd)/builder:/builder:ro" \
   -e BUILD_BRANCH=$(git branch --show-current) \
   debian:trixie \
   bash /builder https://github.com/your-user/Your-Module.git
</code></pre>
<p><em>Note: a repository URL is currently required - <code>builder</code> does not
yet support building an already-checked-out project mounted directly
into the container.</em></p>
<a id="environment-variables" class="anchor" aria-label="Permalink: Environment variables" href="#environment-variables"><span aria-hidden="true" class="octicon octicon-link"></span></a><h3 class="heading-element">Environment variables</h3>
<ul>
<li>
<p><code>INSTALLER</code></p>
<p>Which tool <code>builder</code> uses to install dependencies. Accepts <code>cpm</code> or
<code>cpanm</code>-based values.</p>
<p>default: <code>cpm install -g --show-build-log-on-failure --verbose</code></p>
</li>
<li>
<p><code>PERLTIDYRC</code> / <code>PERLCRITICRC</code></p>
<p><code>builder</code> searches the checked-out repository for <code>.perltidyrc</code> or
<code>perltidyrc</code> (respectively <code>.perlcriticrc</code>/<code>perlcriticrc</code>) and
exports them automatically. When found, <code>builder</code> also installs
<code>Perl::Tidy</code> or <code>Perl::Critic</code> (plus the community/compatibility
policy modules) as extra build dependencies before running <code>make</code>.</p>
</li>
<li>
<p><code>BUILD_BRANCH</code> / <code>GITHUB_REF_NAME</code></p>
<p>The branch to check out and build. <code>GITHUB_REF_NAME</code> is set
automatically by GitHub Actions; <code>BUILD_BRANCH</code> is the equivalent
override for manual or non-GitHub runs. Falls back to the current
branch if neither is set.</p>
</li>
</ul>
<a id="override-files" class="anchor" aria-label="Permalink: Override files" href="#override-files"><span aria-hidden="true" class="octicon octicon-link"></span></a><h3 class="heading-element">Override files</h3>
<p>Commit these to your project root to customize a CI build without
touching <code>builder</code> itself:</p>
<ul>
<li>
<p><code>build-apt-deps</code></p>
<p>Whitespace-separated list of additional Debian packages to install
before the build (<code>builder</code> always installs a minimal base:
<code>git gcc make perl curl ca-certificates libexpat-dev libssl-dev libzip-dev</code>).</p>
</li>
<li>
<p><code>build-mirrors</code></p>
<p>One CPAN mirror URL per line - for example, your DarkPAN. Merged with
<code>https://cpan.metacpan.org</code> when resolving dependencies.</p>
</li>
</ul>
<a id="make-build-ci-variables" class="anchor" aria-label="Permalink: make build-ci variables" href="#make-build-ci-variables"><span aria-hidden="true" class="octicon octicon-link"></span></a><h3 class="heading-element">make build-ci variables</h3>
<p><code>make build-ci</code> wraps the manual docker invocation above. It accepts:</p>
<pre><code>DOCKER_BUILD_IMAGE  - container image to build in (default: debian:trixie)
BRANCH              - branch to build (default: current branch)
INSTALLER           - see L&lt;/Environment variables&gt; above (default: cpm)
BUILD_LOG           - path to write build output (default: timestamped)
</code></pre>
<a id="see-also-1" class="anchor" aria-label="Permalink: See Also" href="#see-also-1"><span aria-hidden="true" class="octicon octicon-link"></span></a><h3 class="heading-element">See Also</h3>
<p><a href="#make-workflow">"make workflow"</a>, <a href="#make-build-ci">"make build-ci"</a></p>
<a id="prerequisites" class="anchor" aria-label="Permalink: PREREQUISITES" href="#prerequisites"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">PREREQUISITES</h1>
<p>The following tool(s) must be on your <code>PATH</code>:</p>
<ul>
<li>
<code>git</code> - used to read global identity config</li>
<li>
<code>make</code> - GNU make is required to build the project</li>
<li>
<code>curl</code> - used by <code>make upgrade</code> to query MetaCPAN</li>
</ul>
<a id="caveats" class="anchor" aria-label="Permalink: CAVEATS" href="#caveats"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">CAVEATS</h1>
<ul>
<li>
<p><code>.pm</code> and <code>.pl</code> Generation</p>
<p>These files are generated from <code>.pm.in</code> and <code>.pl.in</code> files in the
Makefile by filtering them through a <code>sed</code> command that replaces
certain tokens like <code>@PACKAGE_VERSION@</code> with values. The
generated files are read-only. Always edit the <code>.in</code> file version.</p>
<p>Use <code>@PACKAGE_VERSION@</code> like this:</p>
<p><code>our $VERSION ='``@PACKAGE_VERSION@``';</code></p>
</li>
<li>
<p>The import feature cannot be used with <code>--stub</code></p>
</li>
<li>
<p>git</p>
<p>There is an assumption that users of this script are also <code>git</code>
users. <code>git</code> is required to run <code>make git</code> which instatiates a git
project and makes an intial commit. It's also used to look into your
<code>.gitconfig</code> file for your name and email address to populate the
certain element in the resources file used when building your CPAN
distribution.</p>
</li>
</ul>
<a id="faq" class="anchor" aria-label="Permalink: FAQ" href="#faq"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">FAQ</h1>
<a id="my-build-is-failing-with-a-module-not-found-error-during-syntax" class="anchor" aria-label="Permalink: My build is failing with a module not found error during syntax" href="#my-build-is-failing-with-a-module-not-found-error-during-syntax"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">My build is failing with a module not found error during syntax</h2>
<p>checking</p>
<p>This is almost always a build-time dependency ordering issue. If
<code>lib/Foo/Bar.pm</code> uses <code>lib/Foo.pm</code>, make may attempt to build and
syntax-check <code>Foo/Bar.pm</code> before <code>Foo.pm</code> exists. Declare the
dependency in <code>project.mk</code>:</p>
<pre><code>lib/Foo/Bar.pm: lib/Foo.pm
</code></pre>
<p>This tells make to build <code>Foo.pm</code> first. See <a href="#inter-module-dependencies">"Inter-module
dependencies"</a> for details.</p>
<p>If the module genuinely cannot be loaded outside its runtime
environment (an Apache handler, a mod_perl module, etc.), add it to
<code>PERLWC_SKIP</code> in <code>project.mk</code>:</p>
<pre><code>PERLWC_SKIP = lib/My/Apache/Handler.pm
</code></pre>
<a id="how-do-i-do-a-fast-build-during-development" class="anchor" aria-label="Permalink: How do I do a fast build during development?" href="#how-do-i-do-a-fast-build-during-development"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">How do I do a fast build during development?</h2>
<pre><code>make quick
</code></pre>
<p>This disables dependency scanning and all linting (syntax checking,
perltidy, perlcritic) for the current build. Your <code>requires</code> and
<code>test-requires</code> files are not updated and no quality gates run.</p>
<p>Use <code>make</code> without flags when you are ready to do a full build before
committing or releasing.</p>
<p>You can also disable individual features:</p>
<pre><code>make SCAN=off          # skip dependency scanning only
make LINT=off          # skip all linting only
make SYNTAX_CHECKING=off  # skip syntax checking only
</code></pre>
<a id="how-do-i-add-a-new-module-or-script-to-the-project" class="anchor" aria-label="Permalink: How do I add a new module or script to the project?" href="#how-do-i-add-a-new-module-or-script-to-the-project"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">How do I add a new module or script to the project?</h2>
<p>Create the source file with the <code>.pm.in</code> or <code>.pl.in</code> extension in
the appropriate directory:</p>
<pre><code>lib/My/New/Module.pm.in
bin/my-script.pl.in
</code></pre>
<p>The build system discovers them automatically via <code>find-files</code> - no
changes to the Makefile are required. The next <code>make</code> will include
them in the dependency scan and the distribution.</p>
<a id="how-do-i-include-additional-files-in-the-distribution" class="anchor" aria-label="Permalink: How do I include additional files in the distribution?" href="#how-do-i-include-additional-files-in-the-distribution"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">How do I include additional files in the distribution?</h2>
<p>Edit <code>buildspec.yml</code> and add entries to the <code>extra-files</code> section:</p>
<pre><code>extra-files:
  - ChangeLog
  - README.md
  - share:
    - my-config-template.yml
    - my-data-file.json
</code></pre>
<p>Files listed under <code>share:</code> are installed into the distribution's
share directory and can be accessed at runtime via
<a href="https://metacpan.org/pod/File%3A%3AShareDir" rel="nofollow">File::ShareDir</a>.</p>
<a id="i-want-to-pin-a-version-or-add-a-module-the-scanner-missed" class="anchor" aria-label="Permalink: I want to pin a version or add a module the scanner missed" href="#i-want-to-pin-a-version-or-add-a-module-the-scanner-missed"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">I want to pin a version or add a module the scanner missed</h2>
<p>Edit <code>requires</code> directly. Prefix the module name with <code>+</code> to make
the entry sticky - it will survive all subsequent rescans even if the
scanner no longer detects it:</p>
<pre><code>+My::Required::Module 1.5
</code></pre>
<p>To pin a version without making the entry sticky, just set the version
number. The scanner will preserve your version if it detects a
different one on subsequent builds:</p>
<pre><code>Some::Module 2.0
</code></pre>
<p>These two mechanisms are independent - <code>+</code> controls survivability,
the version number controls what version is required. See <a href="#dependencies">"Dependencies"</a>
for full details.</p>
<a id="i-want-to-exclude-a-module-the-scanner-found" class="anchor" aria-label="Permalink: I want to exclude a module the scanner found" href="#i-want-to-exclude-a-module-the-scanner-found"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">I want to exclude a module the scanner found</h2>
<p>Create a <code>requires.skip</code> file in the project root with one module
name per line:</p>
<pre><code>My::Own::Module
Some::Transitive::Dep
</code></pre>
<p>The scanner will never add these to <code>requires</code>. Use
<code>test-requires.skip</code> for the same effect on test dependencies.</p>
<p>Note that on a clean first build neither skip file has any effect
since there is no prior <code>requires</code> file to compare against. The skip
list takes effect from the second build onward.</p>
<a id="i-edited-a-pm-file-and-my-changes-disappeared" class="anchor" aria-label="Permalink: I edited a .pm file and my changes disappeared" href="#i-edited-a-pm-file-and-my-changes-disappeared"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">I edited a .pm file and my changes disappeared</h2>
<p>The <code>.pm</code> files in <code>lib/</code> are generated from the <code>.pm.in</code> sources
and are write-protected. Always edit the <code>.pm.in</code> file - the <code>.pm</code>
is regenerated on every <code>make</code> and your changes will be lost.</p>
<p>If you are unsure which file to edit:</p>
<pre><code>ls -l lib/My/Module.pm lib/My/Module.pm.in
</code></pre>
<p>The <code>.pm.in</code> file is the one you own.</p>
<a id="why-does-my-build-say-it-has-drifted-from-the-installed-bootstrapper" class="anchor" aria-label="Permalink: Why does my build say it has drifted from the installed bootstrapper?" href="#why-does-my-build-say-it-has-drifted-from-the-installed-bootstrapper"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Why does my build say it has drifted from the installed bootstrapper?</h2>
<p>This means your project's managed files (<code>Makefile</code>,
<code>.includes/*.mk</code>) no longer match what your <em>currently installed</em>
<code>CPAN::Maker::Bootstrapper</code> would generate. There are two ways this
happens - upgrading your bootstrapper (e.g. via <code>cpanm \--upgrade-all</code>) instantly "drifts" every project you haven't yet
updated, or a managed file was edited by hand. Both are fixed the
same way:</p>
<pre><code>make update
</code></pre>
<p>If you don't want a drifted project to fail the build outright, set
<code>CMB_VERSION_DRIFT=warn</code> (or <code>=ignore</code>) in that project's
<code>config.mk</code>. See <a href="#automatic-drift-and-update-checks">"Automatic Drift and Update Checks"</a>.
=head2 make update overwrote something I changed in a managed file</p>
<p>The managed files in <code>.includes/</code> should never be edited directly -
that is what <code>project.mk</code> is for. However if you did modify a managed
file and <code>make update</code> overwrote it, git has you covered:</p>
<pre><code>git diff .includes/perl.mk
git checkout .includes/perl.mk
</code></pre>
<p>This is why <code>make git</code> and committing your <code>.includes/</code> directory is
strongly recommended - git is your safety net for the entire build
system.</p>
<a id="make-says-nothing-to-do-but-my-source-changed" class="anchor" aria-label="Permalink: make says nothing to do but my source changed" href="#make-says-nothing-to-do-but-my-source-changed"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">make says nothing to do but my source changed</h2>
<p>The most common cause is that the generated <code>.pm</code> file is newer than
the <code>.pm.in</code> source. This can happen if you accidentally edited the
<code>.pm</code> directly or if file timestamps got out of sync. Force a rebuild:</p>
<pre><code>touch lib/My/Module.pm.in
</code></pre>
<p>Or do a clean rebuild:</p>
<pre><code>make clean &amp;&amp; make
</code></pre>
<a id="how-do-i-disable-scanning-temporarily" class="anchor" aria-label="Permalink: How do I disable scanning temporarily?" href="#how-do-i-disable-scanning-temporarily"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">How do I disable scanning temporarily?</h2>
<pre><code>make SCAN=off
</code></pre>
<p>This skips the dependency scan entirely for that run - useful when
you have many modules and want a fast build during active development.
The default is <code>SCAN=ON</code>.</p>
<a id="how-do-i-disable-syntax-checking-temporarily" class="anchor" aria-label="Permalink: How do I disable syntax checking temporarily?" href="#how-do-i-disable-syntax-checking-temporarily"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">How do I disable syntax checking temporarily?</h2>
<pre><code>make SYNTAX_CHECKING=off
</code></pre>
<p>Similarly you can disable individual quality gates:</p>
<pre><code>make PERLTIDYRC="" PERLCRITICRC=""
</code></pre>
<a id="how-do-i-upgrade-the-build-system" class="anchor" aria-label="Permalink: How do I upgrade the build system?" href="#how-do-i-upgrade-the-build-system"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">How do I upgrade the build system?</h2>
<pre><code>make upgrade
</code></pre>
<p>This checks MetaCPAN for a newer version of
<code>CPAN::Maker::Bootstrapper</code>, installs it via <code>cpanm</code>, and
automatically refreshes the managed files in <code>.includes/</code> with
<code>make update</code>. Review the changes with <code>git diff</code> and revert
anything you don't want with <code>git checkout</code>.</p>
<p>If <code>cpanm</code> is not installed:</p>
<pre><code>make cpanm &amp;&amp; make upgrade
</code></pre>
<a id="i-want-to-add-a-bash-script-to-my-distribution" class="anchor" aria-label="Permalink: I want to add a bash script to my distribution" href="#i-want-to-add-a-bash-script-to-my-distribution"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">I want to add a bash script to my distribution</h2>
<p>Create the script in <code>bin/</code> with a <code>.sh.in</code> extension:</p>
<pre><code>bin/my-script.sh.in
</code></pre>
<p>The build system will process it through the standard token
substitution (replacing <code>@PACKAGE_VERSION@</code> and
<code>@MODULE_NAME@</code>), make it executable, and include it in the
distribution automatically.</p>
<p>If your script is more than a few lines of bash, consider writing it
as a <em>modulino</em> instead - a Perl module that doubles as a runnable
script. Modulinos are easier to test, encourage encapsulation, and
give you the full power of Perl and CPAN. The build system has
first-class support for them:</p>
<pre><code>make modulino
</code></pre>
<p>This generates a bash wrapper in <code>bin/</code> that invokes your module as
a script if it uses the modulino pattern:</p>
<pre><code>caller or __PACKAGE__-&gt;main;
</code></pre>
<p>See <a href="#modulinos">"MODULINOS"</a> for full details.</p>
<div class="markdown-heading"><h2 class="heading-element">What is <code>make release-notes</code> used for?</h2><a id="what-is-make-release-notes-used-for" class="anchor" aria-label="Permalink: What is make release-notes used for?" href="#what-is-make-release-notes-used-for"><span aria-hidden="true" class="octicon octicon-link"></span></a></div>
<p><code>make release-notes</code> generates three artifacts comparing the current
working state of your repository against the previous git tag:</p>
<ul>
<li>
<code>release-&lt;version&gt;.diffs</code> - a unified diff of all
changed files</li>
<li>
<code>release-&lt;version&gt;.lst</code> - a list of added, modified,
and removed files</li>
<li>
<code>release-&lt;version&gt;.tar.gz</code> - a tarball containing
only the changed files</li>
</ul>
<p>These are primarily useful for generating release notes and changelogs,
and for submitting targeted patches. Run it after bumping the version
with <code>make release</code>, <code>make minor</code>, or <code>make major</code> and before
publishing to CPAN:</p>
<pre><code>make minor
make release-notes
# review release-1.1.0.diffs
make
</code></pre>
<p>The artifacts are all the clues needed for LLMs to produce accurate
and well written release notes for your project.</p>
<p>The release artifacts are cleaned up by <code>make clean</code>.</p>
<a id="can-i-distribute-the-pod-in-my-modules-separately" class="anchor" aria-label="Permalink: Can I distribute the POD in my modules separately?" href="#can-i-distribute-the-pod-in-my-modules-separately"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Can I distribute the POD in my modules separately?</h2>
<p>When you package your CPAN distribution you can strip the pod from
your modules or you can extract the pod and provide them as separate
<code>.pod</code> files. There are two <code>make</code> environment variables you can set
to control that behavior.</p>
<ul>
<li>
<p><code>make POD=extract</code></p>
<p><code>extract</code> will strip POD from your module and create a <code>.pod</code> file
containing the stripped POD that will be added to your distribution.</p>
</li>
<li>
<p><code>make POD=remove</code></p>
<p><code>remove</code> will strip POD from your module. No POD will be included in
the distribution.</p>
</li>
</ul>
<a id="the-dependency-resolver-keeps-adding-a-file-i-dont-want-to" class="anchor" aria-label="Permalink: The dependency resolver keeps adding a file I don't want to" href="#the-dependency-resolver-keeps-adding-a-file-i-dont-want-to"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">The dependency resolver keeps adding a file I don't want to</h2>
<p>list. How can I tell it to skip those files?</p>
<p>Add a <code>requires.skip</code> file to exclude modules from the scanned
list. Sometimes the scanner may include modules that are optional or
modules you just don't want to include as requirements because they
are already included in a module you have already required.</p>
<p>Similarly, <code>test-requires.skip</code> excludes modules from the test
dependency scan.</p>
<p>On a clean first run neither <code>requires</code> nor <code>test-requires</code> exists
yet, so the raw scanner output becomes the dependency file - meaning
skip list and pins have no effect until the second run.</p>
<a id="something-still-doesnt-work---how-do-i-report-an-issue" class="anchor" aria-label="Permalink: Something still doesn't work - how do I report an issue?" href="#something-still-doesnt-work---how-do-i-report-an-issue"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Something still doesn't work - how do I report an issue?</h2>
<p>First check the <a href="#faq">"FAQ"</a> sections above - your
issue may already be covered.</p>
<p>If you believe you have found a bug or want to request a feature,
please open an issue on GitHub:</p>
<pre><code>https://github.com/rlauer6/CPAN-Maker-Bootstrapper/issues
</code></pre>
<p>When reporting a bug please include:</p>
<ul>
<li>The version of <code>CPAN::Maker::Bootstrapper</code> (<code>cmb --version</code>
or <code>perl -MCPAN::Maker::Bootstrapper -e 'print $CPAN::Maker::Bootstrapper::VERSION'</code>)</li>
<li>The output of <code>make -n</code> or <code>make --debug=v</code> if the issue is
build-related</li>
<li>Your <code>buildspec.yml</code> and <code>project.mk</code> if relevant (redact
any sensitive information)</li>
<li>The Perl and GNU make versions (<code>perl --version</code>, <code>make --version</code>)</li>
<li><strong>MAKE SURE YOUR SUBMISSION DOES NOT CONTAIN SECRETS!</strong></li>
</ul>
<p>Pull requests are welcome. The project follows the standard GitHub
fork-and-PR workflow.</p>
<a id="see-also-2" class="anchor" aria-label="Permalink: SEE ALSO" href="#see-also-2"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">SEE ALSO</h1>
<p><a href="https://metacpan.org/pod/CPAN%3A%3AMaker" rel="nofollow">CPAN::Maker</a> - the distribution builder driven by <code>buildspec.yml</code>
(includes <code>make-cpan-dist.pl</code>)</p>
<p><a href="https://metacpan.org/pod/CLI%3A%3ASimple" rel="nofollow">CLI::Simple</a> - the CLI framework used by the bootstrapper itself and
optionally by generated CLI module stubs</p>
<p><a href="https://metacpan.org/pod/CPAN%3A%3AMaker%3A%3AConfigReader" rel="nofollow">CPAN::Maker::ConfigReader</a> - the git config reader bundled with this
distribution, available for use in your own
tools.</p>
<p><a href="https://metacpan.org/pod/LLM%3A%3AAPI" rel="nofollow">LLM::API</a> - client interface to Anthropic's Claude API</p>
<p><a href="https://metacpan.org/pod/Module%3A%3AScanDeps%3A%3AStatic" rel="nofollow">Module::ScanDeps::Static</a> - the static dependency scanner used by
<code>make requires</code> and <code>make test-requires</code> to analyze your source files</p>
<a id="dependencies" class="anchor" aria-label="Permalink: DEPENDENCIES" href="#dependencies"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">DEPENDENCIES</h1>
<pre><code>CLI::Simple::Constants
CLI::Simple::Utils
CPAN::Maker::ConfigReader
Cwd
English
Email::Valid
File::Basename
File::Copy
File::Find
File::Path
File::ShareDir
File::Temp
JSON::PP
List::Util
Module::Metadata;
</code></pre>
<a id="required-for-ai-commands" class="anchor" aria-label="Permalink: Required for AI Commands" href="#required-for-ai-commands"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Required for AI Commands</h2>
<pre><code>Archive::Tar
Pod::Extract (required for code-review command)
Text::ASCIITable;
</code></pre>
<a id="recommend-packages" class="anchor" aria-label="Permalink: Recommend Packages" href="#recommend-packages"><span aria-hidden="true" class="octicon octicon-link"></span></a><h2 class="heading-element">Recommend Packages</h2>
<pre><code>Term::ANSIColor
</code></pre>
<a id="version" class="anchor" aria-label="Permalink: VERSION" href="#version"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">VERSION</h1>
<p>This documentation refers to version 2.1.0</p>
<a id="author" class="anchor" aria-label="Permalink: AUTHOR" href="#author"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">AUTHOR</h1>
<p>Rob Lauer - <a href="mailto:rlauer@treasurersbriefcase.com">rlauer@treasurersbriefcase.com</a></p>
<a id="license" class="anchor" aria-label="Permalink: LICENSE" href="#license"><span aria-hidden="true" class="octicon octicon-link"></span></a><h1 class="heading-element">LICENSE</h1>
<p>Copyright 2026, Robert C. Lauer All right reserved.</p>
<p>This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.</p>
