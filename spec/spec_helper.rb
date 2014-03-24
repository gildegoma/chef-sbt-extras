require 'bundler/setup'
require 'chefspec'
require 'chefspec/deprecations'

module SbtExtrasChefSpecHelpers
  def create_chefspec_runner
    chef_run = ChefSpec::Runner.new({ :cookbook_path => 'tmp/cookbooks' })
  end
end

RSpec.configure do |config|
  config.include(SbtExtrasChefSpecHelpers)
end
