require 'bundler/gem_tasks'
require 'yard'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'inch/rake'

Inch::Rake::Suggest.new
YARD::Rake::YardocTask.new
RuboCop::RakeTask.new
RSpec::Core::RakeTask.new('spec')

task default: %w[spec rubocop]
