require 'bundler/setup'
require 'chefspec'
require 'chefspec/deprecations'

module SbtExtrasChefSpecHelpers
  def create_chefspec_runner
    chef_run = ChefSpec::SoloRunner.new({ :cookbook_path => 'tmp/cookbooks' })
  end
end

RSpec.configure do |config|
  config.include(SbtExtrasChefSpecHelpers)
end
