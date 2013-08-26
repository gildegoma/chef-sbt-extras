case platform
when 'mac_os_x'
  set['sbt-extras']['user_home_basedir']       = '/Users'
else # usual base directory on unix systems:
  set['sbt-extras']['user_home_basedir']       = '/home'
end

default['sbt-extras']['download_url']          = 'https://github.com/paulp/sbt-extras/raw/f19a3e4fe1dab69c06e249a2db3cc1934b7bf4b9/sbt'

default['sbt-extras']['setup_dir']             = '/usr/local/bin'
default['sbt-extras']['script_name']           = 'sbt'
default['sbt-extras']['owner']                 = 'root'
default['sbt-extras']['group']                 = 'root'

default['sbt-extras']['config_dir']            = '/etc/sbt'

# Template installation is disabled if attribute below is nil or an empty string:
default['sbt-extras']['sbtopts']['filename']   = 'sbtopts'
default['sbt-extras']['jvmopts']['filename']   = 'jvmopts'

default['sbt-extras']['jvmopts']['total_memory']      = 512        # in megabytes, used to define default JVM settings (like -Xmx, -Xms and so on)
default['sbt-extras']['jvmopts']['thread_stack_size'] = 6          # in megabytes, used to define default JVM settings (like -Xmx, -Xms and so on)

#
# sbt pre-installation (optional)
#

default['sbt-extras']['preinstall_cmd']['timeout'] = 300 # A maximum of 5 minutes is allowed to download dependencies of a specific sbt launcher 

# Optionally pre-install dependant libraries of requested sbt versions in user own environment
#default['sbt-extras']['preinstall_matrix']['coder1'] = %w{ 0.12.1 0.12.0 0.11.3 0.11.2 0.11.1 }
  # Known Problem: sbt 'boot' libraries are correclty installed since 0.11+
  # (see https://github.com/gildegoma/chef-sbt-extras/issues/5#issuecomment-10576361)
