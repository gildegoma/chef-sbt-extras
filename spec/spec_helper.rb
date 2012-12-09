require 'bundler/setup'
require 'chefspec'

module SbtExtrasChefSpecHelpers
  def create_chefspec_runner
    chef_run = ChefSpec::ChefRunner.new({ :cookbook_path => 'tmp/cookbooks' })
  end
end

RSpec.configure do |config|
  config.include(SbtExtrasChefSpecHelpers)
end
