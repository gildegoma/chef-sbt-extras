require 'spec_helper'

describe 'Integration of sbt-extras cookbook' do
  let(:chef_run) {
    chef_run = create_chefspec_runner
    chef_run.converge 'sbt-extras::default'
  }

  it 'should include external recipe for java dependency' do
    chef_run.should include_recipe 'java'
  end
end
