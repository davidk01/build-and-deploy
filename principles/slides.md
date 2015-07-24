!SLIDE title-slide
# Build #
# Deploy #
# ??? #
# Profit #

!SLIDE title-slide
# about me #

!SLIDE bullets 
* eBay Local, Milo
* Release/Quality Engineering
* Platform Tooling/Maintenance
* dkarapetyan@ebay.com
* MiloReleaseEngineering@github

!SLIDE title-slide incremental bullets
# General Principles #
# (for platform tools) #
* Take Something Away
* Give Something Back
* Make it Composable
* (A=>B && B=>C ==> A=>C)

!SLIDE title-slide incremental
# Take Something Away #
* Enforce Folder Structure
* Require Specific Metadata
* Control Deployment Process

!SLIDE title-slide incremental
# Give Something Back #
* Automatic Building & Versioning
* Easy Rollbacks
* Dependency Resolution
* Pre/Post Install Hooks

!SLIDE title-slide bullets incremental
# Make it Composable #
# (A=>B && B=>C ==> A=>C) #
* Build Artifacts (.deb, .rpm, .jar, etc.)
* Seperate Dependencies
* Be Agnostic to Orchestration (puppet, cfengine, cronus, etc.)
* Fail Gracefully

!SLIDE title-slide bullets incremental
# Example #
# (milo build pipeline) #
* GIT tags for versions
* requirements.txt
* test_requirements.txt
* debian_requirements.txt
* chef-solo

!SLIDE bullets
# Questions #
* github/MiloReleaseEngineering
