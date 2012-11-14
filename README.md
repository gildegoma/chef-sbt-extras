
Description
===========

This cookbook will install [sbt-extras](https://github.com/paulp/sbt-extras), an alternative script for running [sbt](https://github.com/harrah/xsbt). sbt-extras works with sbt 0.7.x projects as well as 0.10+. If you're in an sbt project directory, the runner will figure out the versions of sbt and scala required by the project and download them if necessary.

The **default** recipe of this Chef cookbook will:

* Download and install the sbt-extras script (e.g. from a github commit/branch/tag) 
* Potentially grant some (or even all) users to download/install on demand the required sbt/scala versions.
* Optionally trigger the installation of some sbt/scala dependencies for specific users (see the *'Optional Attributes'* section below)

Requirements
============

* Depends on **opscode/java** cookbook
* Conflicts with **gildegoma/typesafe-stack** cookbook

Attributes
==========

* `node['sbt-extras']['download_url']` - URL to obtain a specific version of sbt-extras script  
* `node['sbt-extras']['setup_dir']` - Target directory for installation (default: `/opt/sbt-extras`)
* `node['sbt-extras']['preinstall']['user_home_basedir']` - base directory where user home folders are stored (example: `/home`)
* `node['sbt-extras']['script_name']` - Name of the installed script (default: `sbt`).
* `node['sbt-extras']['preinstall']['sbt_opts']` - sbt-extras args given during chef provisioning (example: `-mem 256`, to let sbt execute on small-RAM systems)
* `node['sbt-extras']['owner']` - user owner of installed resources (default: `root`)
* `node['sbt-extras']['group']` - group owner of installed resources (default: `sbt`). **Important:** Members of this group are granted to auto-download/setup on demand any missing versions of sbt (setgid flag is set on `node['sbt-extras']['setup_dir']/.lib` and download files are ``002` umasked.
* `node['sbt-extras']['group_new_members']` - Members of `node['sbt-extras']['group']`, *to be appended if the group already exists*.

## Optional Attributes

* `node['sbt-extras']['bin_symlink']` - sbt-extras script will be linked from this location, *only if this attribute is defined!* (enabled by default to: `/usr/bin/sbt`)
* `node['sbt-extras']['preinstall'][<user_name>][<sbt_version>][<scala_versions]` - Matrix of sbt/scala versions to pre-install during chef provisioning. Examples: 

```ruby
node['sbt-extras']['preinstall']['old_geek']['0.10.1'] = %w{ 2.8.2 2.8.1 }
node['sbt-extras']['preinstall']['old_geek']['0.11.3'] = %w{ 2.9.2 2.8.2 }
node['sbt-extras']['preinstall']['old_geek']['0.12.1'] = %w{ 2.10.0-RC2 2.9.2 2.9.1 2.9.0-1 }
node['sbt-extras']['preinstall']['scala_hacker']['0.12.1'] = %w{ 2.10.0-RC2 }
``` 

Installation and Usage
======================

* Find your favourite way (Librarian-Chef, knife-github-cookbooks, Git submodule, Opscode community API or even tarball download) to install this cookbook (and its dependency). **[Librarian](https://github.com/applicationsonline/librarian#readme) is a very nice cookbook bundler!**
* Include the `sbt-extras::default` recipe to your run list or inside your cookbook.
* Provision!

Quality Assurance
=================

Version 0.1.0 has been _tasted_ by:

* a [foodcritic](http://acrmp.github.com/foodcritic/)
* Ubuntu 12.10 64-bit, ChefSolo 10.16.2 and java cookbook 1.6.0 (openjdk)
* CentOS 6.3 64-bit, ChefSolo 10.14.2 and java cookbook 1.6.0 (openjdk)

How to Contribute
=================

*Feel free to open issues, fork repo and send pull request (based on a custom branch, not master)!*

License
=======

* Copyright:: 2012, Gilles Cornu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
