require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :connect do
  `java -jar vendor/kgsGtp-3.5.10/kgsGtp.jar creds.plist`
end

task :default => :spec
