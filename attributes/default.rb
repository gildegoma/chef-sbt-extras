case platform
when 'mac_os_x'
  set['sbt-extras']['user_home_basedir']       = '/Users'
else # usual base directory on unix systems:
  set['sbt-extras']['user_home_basedir']       = '/home'
end

default['sbt-extras']['download_url']          = 'https://raw.github.com/gildegoma/sbt-extras/229a2e6aa9e7dd8535720acf7fa1c4803fc43063/sbt'
                                                 # switch to https://raw.github.com/paulp/sbt-extras/master/sbt
                                                 # is pending on https://github.com/paulp/sbt-extras/pull/62

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
default['sbt-extras']['jvmopts']['thread_stack_size'] = 3         # in megabytes, used to defined -Xss option

#
# Optionally pre-install scala/sbt base dependencies in user home (~/.sbt/boot/..., ~/.ivy2/cache/...)
#
# Known Problem: sbt 'boot' libraries are correclty installed only since sbt 0.11+
# see gildegoma/chef-sbt-extras#5 for more details
#
# Example:
# default['sbt-extras']['user_setup']['user1']['sbt'] = %w{ 0.13.0 0.12.4 0.11.3 }
# default['sbt-extras']['user_setup']['user1']['scala'] = %w{ 2.10.2 2.10.1 2.9.3 2.9.2 }
