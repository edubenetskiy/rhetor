# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rhetor/version'

Gem::Specification.new do |spec|
  spec.name = 'rhetor'
  spec.version = Rhetor::VERSION
  spec.authors = ['Egor Dubenetskiy']
  spec.email = ['edubenetskiy@ya.ru']
  spec.summary = 'Rhetor is yet another lexical analyser written in Ruby'
  spec.description = 'Rhetor is yet another lexical analyser library
                        written in pure Ruby with no runtime dependencies,
                        properly documented and easy-to-use.'
  spec.homepage = 'https://github.com/edubenetskiy/rhetor/'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'rubocop', '~> 0.28'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.2'
  spec.add_development_dependency 'inch', '~> 0.5'
  spec.add_development_dependency 'yard', '~> 0.8'
end
