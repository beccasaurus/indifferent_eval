require "rspec/core/rake_task"

desc 'Default: run specs'
task :default => :spec

desc 'Run tests'
task :test => :spec

desc 'Run sample.rb'
task :sample do
  exec "bundle exec ruby sample.rb"
end

desc "Run specs"
RSpec::Core::RakeTask.new
