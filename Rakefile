require 'bundler/gem_tasks'
require 'yard'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'inch/rake'

Inch::Rake::Suggest.new
YARD::Rake::YardocTask.new
RuboCop::RakeTask.new

namespace :test do
  RSpec::Core::RakeTask.new('spec')

  desc 'Run all test suites with code coverage detail'
  task 'coverage' do
    ENV['COVERAGE'] = 'true'
    rm_rf 'coverage/'
    spec.reenable
    spec.invoke
  end
end

task default: 'test:run'
