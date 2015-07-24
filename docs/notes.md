# Introduction

Pretty much all build and deployment pipelines at the end of the day come down to 3 things:

  1. [Artifact](https://en.wikipedia.org/wiki/Artifact_%28software_development%29) Generation
  2. Dependency Management
  3. Artifact Packaging and Distribution

The only item in the above list that should not be content agnostic is item 1. Everything else in the above list should be agnostic to what is actually contained in the generated artifacts. Fortunately most mature linux distributions already have content agnostic implementations for items 2 and 3. Debian based systems use [.deb](https://en.wikipedia.org/wiki/Deb_%28file_format%29) files for packaging and distribution and Red Hat based systems use [.rpm](https://en.wikipedia.org/wiki/Rpm_%28file_format%29) files.

***

# Artifact Generation

There is no single, general purpose way for generating artifacts. All languages and platforms have their own specific ways of accomplishing it so it is very hard to build a general purpose tool for it. The best one can do is delegate the task to existing tools and practices, e.g. make, ant, maven, rake, setup.py, etc. So for the rest of this document I'm going to assume that there is a magic executable that takes some parameters and generates the required artifacts for packaging as `.deb` or `.rpm` files.

***

# Dependency Management

There are two levels of dependency management. The first is at the language level and the second is at the OS/platform level.

## 1. Langauge Level Dependency Management
Pretty much all modern languages do the right thing when it comes to managing dependencies at the language level. There is usually some kind of custom format and associated metadata that the community agrees on and then there are some tools built around the format and the associated metadata. For common examples you can take a look at gem, egg, wheel, and jar files. So all you have to do for language level dependency management is learn how to use the tools and you should be good to go because many times the tools will handle gathering all your requirements and making them available for development purposes. Deployment is another issue but we'll get to it after discussing platform/OS level dependencies.

## 2. Platform/OS Level Dependency Management
Piggybacking on `.deb` or `.rpm` files greatly simplifies OS/Platform level dependency management because both `apt-get` and `yum` will pretty much do the right thing if you declare your dependencies properly. One tool that can save you a lot of time and effort when it comes to generating `.rpm` and `.deb` files and attaching the proper dependencies is [fpm](https://github.com/jordansissel/fpm/wiki) so learn to use it and you'll be much happier in the long run. 

### Install/Remove Hooks
Leveraging native formats like `.deb` and `.rpm` has another benefit: install/remove hooks. Both `.deb` and `.rpm` files provide hooks for executing code at various stages of the installation and removal process. The code can be written in any language but is usually Bash, Ruby, Perl, or Python. Most linux distributions come with interpreters for all of those built-in so that reduces the number of assumptions you have to make but can potentially increase the complexity of the scripts because we usually want the install/remove scripts to be [idempotent](https://en.wikipedia.org/wiki/Idempotence) and most of the languages I mentioned do not come with idempotent primitives built-in. There is a lot of flexibility in the install/remove hook mechanism so you should tread carefully. If you know ahead of time that frameworks like Chef, Ansible, or Puppet are going to be available then you can leverage the tools provided by those frameworks to write your hooks. One benefit of leveraging frameworks like Chef, Puppet, and Ansible is that the logic can be re-used for setting up development boxes but then again so can Bash scripts. One downside of using Chef, Puppet, or Ansible is that it is one more dependency that you have to worry about. In general you should start with Bash and the usual unix tools and then move on to more complicated things as the need arises because the more you do in those scripts the less help you are going to get from the OS package manager when it comes time to uninstall or upgrade. 

***

# Artifact Packaging and Distribution
So at this point if everything has gone according to plan you should have a `.deb` or `.rpm` file that contains all your artifacts ready to be deployed. Since artifact distribution is another common problem it has alreay been solved for both `.deb` and `.rpm` files. Deploying `.deb` files is as simple as adding them to a debian repository and then adding an entry to `/etc/apt/sources.list`. Once that's done deploying a package is as simple as `sudo apt-get update; sudo apt-get install package`. The same applies to `.rpm` files and yum repositories. The packages can be served by simply pointing apache or nginx to the root directory of your repository. One benefit of serving the packages this way is that you can use HTTP authentication to make the repositories private and allow selective access by distributing user names and passwords to trusted parties. Setting up a yum repository is very simple and can be done by pointing `creatrepo` to a directory that contains `.rpm` files. Apt repositories are a bit more work but I have done all the work for you already. You can get the code at [apt-repo-construction-kit](https://github.com/davidk01/apt-repo-construction-kit). I make a few assumptions and one of those is that you are going to host your apt repository on a box running Ubuntu.

***

# Example Pipeline
So that's all nice and well but how do you go about putting it all into practice. I can only provide a general skeleton but if you segment your pipeline properly then this example should be more than adequate. If you're not already using a continuous integration tool like Jenkins, Go, or Bamboo then setting it all up will be a bit more work but if you are then artifact generation should just be a simple addition to the existing pipeline.

  1. Commit code
  2. Compile
  3. Run unit tests
  4. Shuffle things into place, i.e. create the proper directory structure
  5. Package the correct directory structure with all the necessary artifacts with `fpm`
  6. Push the artifacts to `yum/apt` repository
  7. Re-index the repository metadata to add the new package to the repository index
  8. Deploy new packages to a staging server and run integration tests
