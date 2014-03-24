source 'https://rubygems.org'

gem 'rake'
gem 'tailor'
gem 'chefspec', '~> 3.4.0'
gem 'foodcritic', '>= 3.0.3'

# allow CI to override the version of Chef for matrix testing
gem 'chef', (ENV['CHEF_VERSION'] || '>= 11')

group :integration do
  gem 'berkshelf', '~> 1.4.6' # TODO try to run against 2.0.x or even 3.0.x ?
  gem 'test-kitchen', '~> 1.0.0.beta.2'
  gem 'kitchen-vagrant', '~> 0.11.0'
end

