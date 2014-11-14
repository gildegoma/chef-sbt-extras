
Description
-----------

This cookbook will install [sbt-extras](https://github.com/paulp/sbt-extras), an alternative script for running [sbt (scala build tool)](https://github.com/sbt/sbt). sbt-extras works with sbt 0.7.x projects as well as 0.10+. If you're in an sbt project directory, the runner will figure out the versions of sbt and scala required by the project and download them if necessary.

The **default** recipe of this Chef cookbook will:

* Download and install the sbt-extras script (e.g. from a github commit/branch/tag)
* Optionally deploy some system-wide configuration files (typically in `/etc/sbt/jvmopts` and `/etc/sbt/sbtopts`)
* Optionally trigger the installation of some sbt dependencies for specific users (see the `user_setup` attribute below)

Requirements
------------

* Depends on **opscode/java** cookbook
* Conflicts with [typesafe-stack](http://community.opscode.com/cookbooks/typesafe-stack) and [chef-sbt](http://community.opscode.com/cookbooks/chef-sbt) cookbooks (since it is recommended to install only one sbt launcher on the same machine)

Attributes
----------

* `node['sbt-extras']['download_url']` - URL to obtain a specific version of sbt-extras script.
* `node['sbt-extras']['setup_dir']` - Target directory for installation (default: `/usr/local/bin`). Attention: this cookbook won't create `setup_dir` if does not exist yet (the idea is to force selection of a good location, most probably part of user PATH)
* `node['sbt-extras']['script_name']` - Name of the installed script (default: `sbt`).
* `node['sbt-extras']['owner']` - user owner of installed script (default: `root`)
* `node['sbt-extras']['group']` - group owner of installed script (default: `root`).
* `node['sbt-extras']['config_dir']` - Target directory for global configuration files (default: `/etc/sbt`). The default recipe can potentially install two templates in this directory if their filename attribute is not nil or empty (`''`)
  * `node['sbt-extras']['system_wide_defaults']` - Whether to export `JVM_OPTS=@...` and `SBT_OPTS=@...` to automatically apply global configuration files (default: `false`)
  * `node['sbt-extras']['jvmopts']['filename']` - default jvm arguments can be globally set in this file (default: `jvmopts`)
  * `node['sbt-extras']['jvmopts']['thread_stack_size']` - Set the value for `-Xss` in megabytes
  * `node['sbt-extras']['jvmopts']['total_memory']` - Set the total amount of memory allowed for sbt, so that values like `-Xms` and `-Xmx` can be automatically adapted.
  * `node['sbt-extras']['sbtopts']['filename']` - default sbt arguments can be globally set in this file (disabled by default)
  * `node['sbt-extras']['sbtopts'][...]` - `sbtopts` values such as `-v`, `-batch` and `-no-colors` can be customized with corresponding cookbook attributes.
* `node['sbt-extras']['user_setup']['<user_name>']['sbt'][<array of sbt versions>]` and `node['sbt-extras']['user_setup']['<user_name>']['scala'][<array of scala versions>]` - (optional) sbt and scala boot dependencies will be preinstalled in `~/.sbt` and `~/.ivy2` directories during chef provisioning. Examples:

```ruby
node['sbt-extras']['user_setup']['scala_lover']['sbt'] = %w{ 0.13.6 0.12.4 }
node['sbt-extras']['user_setup']['scala_lover']['scala'] = %w{ 2.11.4 2.10.4 2.9.3 }
```

Installation and Usage
----------------------

* Find your favourite way (Berskhelf, Librarian-Chef, ...) to install this cookbook.
* Include the `sbt-extras::default` recipe to your run list or inside your cookbook.
* Provision!

Quality Assurance
-----------------

### Continuous Integration

This Cookbook is being _tasted_ by Travis CI: [![Build Status](https://secure.travis-ci.org/gildegoma/chef-sbt-extras.png?branch=master)](https://travis-ci.org/gildegoma/chef-sbt-extras)

Automated validations are following:
  * Static Analysis of Ruby code with [tailor](https://github.com/turboladen/tailor#readme) lint tool
  * Static Analysis of Chef Cookbooks with [foodcritic](http://acrmp.github.com/foodcritic/) lint tool
  * `knife cookbook test` in a very basic sandbox
  * Expectations described with RSpec examples with [ChefSpec](https://github.com/acrmp/chefspec)
  * _Pending:_ Run true chef (matrix) on travis VM!

### Development and Testing

During development, this cookbook is locally tested in following environments:
 * Development with *recent* versions of Chef-Solo (10.x or 11.x) and Ubuntu (with great help of Berkshelf, Vagrant, Virtualbox, Packer and their communities).
 * Integration with great help of Opscode [test-kitchen](https://github.com/opscode/test-kitchen)

How to Contribute
-----------------

*Feel free to open issues, fork repo and send pull request (based on a custom branch, not master)!*

License
* Copyright:: 2013, Gilles Cornu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
