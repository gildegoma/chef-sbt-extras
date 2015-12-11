case platform
when 'mac_os_x'
  set['sbt-extras']['user_home_basedir']       = '/Users'
else # usual base directory on unix systems:
  set['sbt-extras']['user_home_basedir']       = '/home'
end

default['sbt-extras']['download_url']          = 'https://raw.githubusercontent.com/paulp/sbt-extras/1203a8bd2f34f7adfa84b6408beb9a14de81c63d/sbt'

default['sbt-extras']['setup_dir']             = '/usr/local/bin'
default['sbt-extras']['script_name']           = 'sbt'
default['sbt-extras']['owner']                 = 'root'
default['sbt-extras']['group']                 = 'root'

default['sbt-extras']['config_dir']            = '/etc/sbt'


#
# Template installation is disabled if attribute below is nil or an empty string:
#

default['sbt-extras']['sbtopts']['filename']          = 'sbtopts'
default['sbt-extras']['sbtopts']['verbose']           = false
default['sbt-extras']['sbtopts']['batch']             = false
default['sbt-extras']['sbtopts']['no-colors']         = false

default['sbt-extras']['jvmopts']['filename']          = 'jvmopts'
default['sbt-extras']['jvmopts']['total_memory']      = 2048      # in megabytes, total memory available for sbt/scala (used to define options like -Xmx, -Xms and so on)
default['sbt-extras']['jvmopts']['thread_stack_size'] = 3         # in megabytes (used to define -Xss option)

default['sbt-extras']['system_wide_defaults']         = false     # if enabled, SBT_OPTS and JVM_OPTS will be exported via /etc/profile.d mechanism.
                                                                  # Be aware that JVM_OPTS can conflict with other Java-based software.

#
# Optionally pre-install scala/sbt base dependencies in user home (~/.sbt/boot/..., ~/.ivy2/cache/...)
#
# Known Problem: sbt 'boot' libraries are correclty installed only since sbt 0.11+
# see gildegoma/chef-sbt-extras#5 for more details
#
# Example:
# default['sbt-extras']['user_setup']['user1']['sbt'] = %w{ 0.13.9 0.12.4 0.11.3 }
# default['sbt-extras']['user_setup']['user1']['scala'] = %w{ 2.11.7 2.10.6 2.9.3 }
