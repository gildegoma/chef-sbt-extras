source 'https://rubygems.org'

gem 'rake'
gem 'tailor'
gem 'chefspec'
gem 'foodcritic'
#gem 'berkshelf', '>= 1.4.0'

# allow CI to override the version of Chef for matrix testing
gem 'chef', (ENV['CHEF_VERSION'] || '>= 0.10.10')

group :integration do
  gem 'berkshelf', '~> 1.3.1' # try to run against latest ...
  gem 'test-kitchen', '~> 1.0.0.alpha.6' # alpha6?
  gem 'kitchen-vagrant', '~> 0.9.0'  # 0.10?
end

