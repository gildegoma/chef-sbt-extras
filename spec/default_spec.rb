require 'spec_helper'

shared_examples_for 'any run of default recipe' do

  it 'creates or modifies the group of power users' do
    chef_run.should create_group chef_run.node['sbt-extras']['group']
  end

  it 'creates setup directory to store sbt-extras and related sbt versions' do
    setup_lib_dir = File.join(chef_run.node['sbt-extras']['setup_dir'], '.lib')
    chef_run.should create_directory setup_lib_dir
    chef_run.directory(setup_lib_dir).should be_owned_by(chef_run.node['sbt-extras']['owner'], chef_run.node['sbt-extras']['group'])
  end

  it 'creates configuration directory to store global settings' do
    config_dir = chef_run.node['sbt-extras']['config_dir']
    chef_run.should create_directory config_dir
    chef_run.directory(config_dir).should be_owned_by(chef_run.node['sbt-extras']['owner'], chef_run.node['sbt-extras']['group'])
  end

  it 'downloads and installs sbt-extras script file' do
    sbt_location = File.join(chef_run.node['sbt-extras']['setup_dir'], chef_run.node['sbt-extras']['script_name'])
    sbt_symlink  = chef_run.node['sbt-extras']['bin_symlink']

    chef_run.should create_remote_file sbt_location
    chef_run.remote_file(sbt_location).should be_owned_by(chef_run.node['sbt-extras']['owner'], chef_run.node['sbt-extras']['group'])

    if sbt_symlink
      chef_run.should create_link sbt_symlink
      chef_run.link(sbt_symlink).should be_owned_by(chef_run.node['sbt-extras']['owner'], chef_run.node['sbt-extras']['group'])
    end
  end

  it 'pre-installs default sbt version' do
    sbt_location   = File.join(chef_run.node['sbt-extras']['setup_dir'], chef_run.node['sbt-extras']['script_name'])

    chef_run.should execute_command "#{sbt_location} -batch -sbt-create"
  end

  context 'when user/sbt pre-install matrix is configured' do
    # TODO: I wonder if it could be a good practice to make some conditional examples this way,
    #       or if it is better to always implement it like below with 'custom attribute' describe group.
    it 'downloads requested sbt versions and run them in user environment'
  end

end

describe 'Running sbt-extras::default with default attributes' do
  let(:chef_run) {
    chef_run = create_chefspec_runner
    chef_run.converge 'sbt-extras::default'
  }

  it_behaves_like 'any run of default recipe'

  it 'creates /usr/bin/sbt symbolic link' do
    chef_run.should create_link '/usr/bin/sbt'
  end

  it 'installs sbtopts template' do
    sbtopts_location = '/etc/sbt/sbtopts'
    #TODO (see issue #18): chef_run.should create_file_with_content sbtopts_location, "-mem #{chef_run.node['sbt-extras']['sbtopts']['mem']}\n"

    chef_run.template(sbtopts_location).should be_owned_by(chef_run.node['sbt-extras']['owner'], chef_run.node['sbt-extras']['group'])

    # TODO: check if ChefSpec still does not support 'only_if' and 'not_if' clauses
  end

  it 'installs jvmopts template' do
    jvmopts_location = '/etc/sbt/jvmopts'
    chef_run.should create_file_with_content jvmopts_location, "-Xms#{(2*chef_run.node['sbt-extras']['jvmopts']['total_memory'])/3}M\n"
    #TODO add more lines
    chef_run.should create_file_with_content jvmopts_location, "-XX:+CMSClassUnloadingEnabled\n"
 
    chef_run.template(jvmopts_location).should be_owned_by(chef_run.node['sbt-extras']['owner'], chef_run.node['sbt-extras']['group'])
    # TODO: check if ChefSpec still does not support 'only_if' and 'not_if' clauses
  end
end

describe 'Running sbt-extras::default with custom attributes' do
  let(:chef_run) {
    chef_run = create_chefspec_runner
    chef_run.node.set['sbt-extras']['owner'] = 'toto'
    chef_run.node.set['sbt-extras']['group_new_members'] = %w{ foo bar }
    chef_run.node.set['sbt-extras']['sbtopts']['mem'] = 2048
    chef_run.node.set['sbt-extras']['setup_dir'] = File.join(%w(usr local sbt-extras))
    chef_run.node.default['sbt-extras'].delete('bin_symlink')
    chef_run.node.set['sbt-extras']['jvmopts_filename'] = 'jvmopts'
    chef_run.converge 'sbt-extras::default'
  }

  it_behaves_like 'any run of default recipe'

  it 'does not create any symbolic link to sbt-extras script' # do
  #  ChefSpec does not support yet 'only_if' and 'not_if' clauses
  #end

  it 'installs jvmopts template' do
    jvmopts_location = File.join(chef_run.node['sbt-extras']['config_dir'], chef_run.node['sbt-extras']['jvmopts_filename'])
    chef_run.should create_file_with_content jvmopts_location, ''
    chef_run.template(jvmopts_location).should be_owned_by(chef_run.node['sbt-extras']['owner'], chef_run.node['sbt-extras']['group'])
  end
end

#TODO sbtopts...
