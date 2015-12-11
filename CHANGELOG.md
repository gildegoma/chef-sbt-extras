# CHANGELOG for sbt-extras cookbook

## v0.4.1 (2015-12-11)

* [GH-33] Update default sbt-extras version to reach repo.typesafe.com

## v0.4.0 (2014-11-14)

* Integrate newer version of paulp/sbt-extras script, which solves following issues:
  - Older launchers are used if the version is declared in `build.properties`
    (see https://github.com/paulp/sbt-extras/pull/67#issuecomment-35973278)
  - Fix a bug in `-sbt-create`, to use `-sbt-version` option.
    The `build.properties` workaround introduced in 0.3.0 could then be removed.
  - Fix a bug in comment skipping for lines with a non-initial #
    (see https://github.com/paulp/sbt-extras/pull/69)
* The attribute `system_wide_defaults` introduced in 0.3.0 was missing in recipe.rb of master repository

* Update to ChefSpec 4.1
* Update to Foodcritic 3.0
* Update to Test-Kitchen 1.2

## v0.3.0 (never officially released)

* The way to refer to global configuration files has changed, see https://github.com/paulp/sbt-extras/pull/43
* Default recipe is far simpler as in 0.2.x! (no more group sid trick, no more shared libraries between user installations,...)
* Preinstallation of sbt and scala boot libraries has been strongly improved

* [GH-17]: Integrate sbt bash script from paulp/sbt-extras original repository
* [GH-15]: Test-Kitchen testing is (partly) supported
* [GH-18]: Clean sbtopts and jvmopts templates

## v0.2.2

* [GH-4]: default recipe is now 100% idempotent
* [GH-5]: User/SBT pre-installation is now coherent and support 0.12 and 0.11 generations.

## v0.2.1

* *administrative* release that only re-packaged 0.2.0, but without unwanted files ('~' backups, .gitignore,...)

## v0.2.0

* [GH-3]: *Optional* templates for global config files (/etc/sbt/sbtopts and /etc/sbt/jvmopts)
* Attributes modified (not backward compatible with 0.1.0)
* Added timeout on 'execute' resources (sbt/scala downloads)

## v0.1.0

* Initial release
