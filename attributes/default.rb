case platform
when 'mac_os_x'
  set['sbt-extras']['user_home_basedir'] = '/Users'
else # usual base directory on unix systems:
  set['sbt-extras']['user_home_basedir'] = '/home'
end

#default['sbt-extras']['download_url'] = 'https://github.com/paulp/sbt-extras/raw/95ff608a0bcc1fccf3e1804c2a5699553f8ae43d/sbt'
# Temporarily refer to yyuu fork, because of issue https://github.com/paulp/sbt-extras/issues/33 (pull request #34 not merged yet)
default['sbt-extras']['download_url']      = 'https://github.com/yyuu/sbt-extras/raw/5c10f03cd77e22bc4f56397bba7cceb74b321737/sbt' 

default['sbt-extras']['setup_dir']         = '/opt/sbt-extras'
default['sbt-extras']['script_name']       = 'sbt'
default['sbt-extras']['bin_symlink']       = '/usr/bin/sbt'
default['sbt-extras']['sbt_opts']          = '-mem 256'
default['sbt-extras']['owner']             = 'root' 
default['sbt-extras']['group']             = 'users'    # or ask to create a new group (e.g. 'sbt') for power users
default['sbt-extras']['group_new_members'] = []         # %w{ admin1 coder1 }

# Optional: List of sbt/scala stacks to install (download) during chef provisioning.
#default['sbt-extras']['preinstall']['coder1']['0.12.1'] = %w{ 2.10.0-RC2 2.9.2 2.8.2 }
#default['sbt-extras']['preinstall']['coder1']['0.11.2'] = %w{ 2.9.2 2.8.2 }
#default['sbt-extras']['preinstall']['coder1']['0.10.1'] = %w{ 2.8.2 2.8.1 2.8.0 }
#default['sbt-extras']['preinstall']['coder2']['0.11.3'] = %w{ 2.9.2 2.9.1 2.9.0-1 2.9.0 }
