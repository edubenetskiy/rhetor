lib = File.expand_path('lib', __dir__)
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
  spec.required_ruby_version = '>= 2.2.10'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'inch', '~> 0.8'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'rubocop', '~> 0.58.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.29'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'yard', '~> 0.9.16'
end
