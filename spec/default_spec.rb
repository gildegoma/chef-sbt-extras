require 'spec_helper'

shared_examples_for 'any run of default recipe' do
  it 'creates configuration directory to store global settings' do
    config_dir = chef_run.node['sbt-extras']['config_dir']
    chef_run.should create_directory config_dir
    expect(chef_run.directory(config_dir).owner).to eq(chef_run.node['sbt-extras']['owner'])
    expect(chef_run.directory(config_dir).group).to eq(chef_run.node['sbt-extras']['group'])
  end

  it 'downloads and installs sbt-extras script file' do
    sbt_location = File.join(chef_run.node['sbt-extras']['setup_dir'], chef_run.node['sbt-extras']['script_name'])

    chef_run.should create_remote_file sbt_location
    expect(chef_run.remote_file(sbt_location).owner).to eq(chef_run.node['sbt-extras']['owner'])
    expect(chef_run.remote_file(sbt_location).group).to eq(chef_run.node['sbt-extras']['group'])
  end

  context 'when user/sbt pre-install matrix is configured' do
    # TODO: I wonder if it could be a good practice to make some conditional examples this way,
    #       or if it is better to always implement it like below with 'custom attribute' describe group.
    it 'downloads requested sbt versions and run them in user environment'
  end
end

shared_examples_for 'any jvmopts template installation' do
  it 'installs jvmopts template' do
    jvmopts_location = '/etc/sbt/jvmopts'
    chef_run.should render_file(jvmopts_location).with_content("-Xms#{(2*chef_run.node['sbt-extras']['jvmopts']['total_memory'])/3}M\n")
    #TODO add more lines
    chef_run.should render_file(jvmopts_location).with_content("-Xss#{chef_run.node['sbt-extras']['jvmopts']['thread_stack_size']}M\n")

    expect(chef_run.template(jvmopts_location).owner).to eq(chef_run.node['sbt-extras']['owner'])
    expect(chef_run.template(jvmopts_location).group).to eq(chef_run.node['sbt-extras']['group'])
    # TODO: check if ChefSpec still does not support 'only_if' and 'not_if' clauses
  end
end

shared_examples_for 'any sbtopts template installation' do
  it 'installs sbtopts template' do
    sbtopts_location = '/etc/sbt/sbtopts'
    chef_run.should render_file("/etc/sbt/sbtopts").with_content("-batch\n")
    #TODO add more lines
    expect(chef_run.template(sbtopts_location).owner).to eq(chef_run.node['sbt-extras']['owner'])
    expect(chef_run.template(sbtopts_location).group).to eq(chef_run.node['sbt-extras']['group'])

    #TODO: check if ChefSpec still does not support 'only_if' and 'not_if' clauses
  end
end

describe 'Running sbt-extras::default with default attributes' do
  let(:chef_run) {
    chef_run = create_chefspec_runner
    chef_run.converge 'sbt-extras::default'
  }

  it_behaves_like 'any run of default recipe'
  it_behaves_like 'any sbtopts template installation'
  it_behaves_like 'any jvmopts template installation'
end

describe 'Running sbt-extras::default with custom attributes' do
  let(:chef_run) {
    chef_run = create_chefspec_runner
    chef_run.node.set['sbt-extras']['owner'] = 'toto'
    chef_run.node.set['sbt-extras']['sbtopts']['filename'] = ''   # disabled
    chef_run.node.set['sbt-extras']['setup_dir'] = File.join(%w(usr local sbt-extras))
    chef_run.converge 'sbt-extras::default'
  }

  it_behaves_like 'any run of default recipe'
  it 'does not install sbtopts template'  #pending
  it_behaves_like 'any jvmopts template installation'

end
