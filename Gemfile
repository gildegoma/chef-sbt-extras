source 'https://rubygems.org'

gem 'rake'
gem 'tailor'
gem 'chefspec', '~> 4.1'
gem 'foodcritic', '>= 3.0'

# allow CI to override the version of Chef for matrix testing
gem 'chef', (ENV['CHEF_VERSION'] || '>= 11')

group :integration do
  gem 'berkshelf', '~> 2.0' 
  gem 'test-kitchen', '~> 1.2'
  gem 'kitchen-vagrant', :git => 'https://github.com/test-kitchen/kitchen-vagrant.git',
                         :ref => '63f9eef9ac46fc372c117b3d8672088b8df35659' 
                         # waiting for '~> 0.16.0' (https://github.com/test-kitchen/kitchen-vagrant/pull/122Â§)
end

