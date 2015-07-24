!SLIDE title-slide
# Build #
# Deploy #
# ??? #
# Profit #

!SLIDE title-slide
# about me #

!SLIDE incremental 
# work and fun #
* __Work__
   * Milo, eBay Local
   * Release/Quality Engineering
   * Platform Tooling/Maintenance
   * dkarapetyan@ebay.com

* __Fun__
   * github.com/davidk01
   * ruby/jruby/javascript
   * dkarapetyan@gmail.com

!SLIDE subsection
# Build #

!SLIDE bullets incremental
* git repo
* ||
* \/
* ?
* jar, zip, tar, rpm, deb
* (hint: it's not zip or tar or jar)

!SLIDE bullets incremental
# why deb (or rpm) #
* metadata - version, dependencies
* built-in platform tooling 
* install/remove hooks 

!SLIDE bullets incremental
# tracking metadata #
* python => virtualenv, requirements.txt, Vagrant
* ruby => rvm, Gemfile, Rakefile, Vagrant
* ? => Vagrant/Docker/lxc

!SLIDE

    $ tree awesome_ruby_project
    awesome_ruby_project/
    ├── bin
    ├── config
    ├── chef-solo
    │   ├── Cheffile
    │   ├── postinstall.json
    │   └── solo.rb
    ├── Gemfile
    ├── Jarfile
    ├── lib
    ├── debian_requirements.txt
    └── rakefile 

!SLIDE

    $ tree awesome_python_project
	awesome_python_project/
	├── awesome
	├── chef-solo
	│   ├── Cheffile
	│   ├── postinstall.json
	│   └── solo.rb
	├── example.py
	├── requirements.txt
	├── debian_requirements.txt
	├── MANIFEST
	├── README.md
	└── setup.py

!SLIDE bullets incremental
# Examples of (awesome) python projects #
* github.corp:miloapi/miloapiv3
* github.corp:miloapi/miloapiv2x
* github.corp:data/wex

!SLIDE bullets incremental
# Examples of (awesome) ruby projects #
* github.com:davidk01/rpc-experiment
* github.com:davidk01/pegrb

!SLIDE title-slide
# tools #

!SLIDE commandline incremental bullets
# fpm, vagrant, chef #

    $ gem install fpm chef librarian-chef vagrant --no-ri --no-rdoc
    $ sudo apt-get install virtualbox

!SLIDE commandline code incremental
# fpm #

    $ fpm -s dir -t deb -n awesome-deb -v 1.0 \
      --deb-pre-depends libpq5 \
      --deb-pre-depends pgbouncer \
      --deb-pre-depends postgresql (= 9.2) \
      awesome_project_files
    $ sudo dpkg -i awesome-deb_1.0_amd64.deb
    Selecting previously unselected package awesome-deb.
    dpkg: regarding awesome-deb_1.0_amd64.deb containing ... 
     awesome-deb pre-depends on libpq5
      libpq5 is not installed.
    dpkg: error processing awesome-deb_1.0_amd64.deb (--install):
     pre-dependency problem - not installing awesome-deb
    Errors were encountered while processing:
     awesome-deb_1.0_amd64.deb

!SLIDE commandline code incremental
# fpm (cont.) #

    $ fpm -s dir -t deb -n awesome-deb -v 1.0 awesome_project_files
    $ sudo dpkg -i awesome-deb_1.0_amd64.deb
    Selecting previously unselected package awesome-deb.
    (Reading database ... 54040 files and directories currently installed.)
    Unpacking awesome-deb (from awesome-deb_1.0_amd64.deb) ...
    Setting up awesome-deb (1.0) ...

!SLIDE commandline code incremental
# vagrant #

    $ export box_url=http://files.vagrantup.com/precise64.box
    $ vagrant box add precise64 $box_url
    $ vagrant init precise64
    $ vagrant up

!SLIDE bullets incremental
# why vagrant #

* isolation
* consistency
* dependency management
* chef-solo integration

!SLIDE commandline code incremental
# chef (solo) #

    $ knife cookbook create awesome_project_postinstall -o ./

!SLIDE bullets incremental
# Examples of (awesome) chef recipes #
* github.corp:MiloCookbooks/*

!SLIDE subsection
# Deploy #

!SLIDE commandline code incremental

    $ export repo_loc=http://slcmilovh37.slc.ebay.com/milo
    $ echo "deb [arch=amd64] $repo_loc precise-qa main" \
      >> /etc/apt/sources.list
    $ wget -qO- $repo_loc/reposignkey_pub.gpg | \
      sudo apt-key add -
    $ sudo apt-get update
    $ sudo apt-get install package

!SLIDE subsection
# ??? #

!SLIDE title-slide
# Putting it all together #

!SLIDE bullets incremental
* apt-repo-construction-kit
* milobuilder-vagrant-vm
* milo-qa-builder
* git-plugin
* (github.corp:MiloReleaseEngineering)

!SLIDE bullets incremental
# "Build" pipeline #
* git checkout 1.0.1 
* python -m milobuilder.build 
* mv package\_1.0.1\_amd64.all $apt_rep

!SLIDE subsection
# Profit #

!SLIDE title-slide
# Questions #
