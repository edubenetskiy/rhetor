# Rhetor

[![GitHub](https://img.shields.io/badge/github-edubenetskiy/rhetor-blue.svg)](https://github.com/edubenetskiy/rhetor)
[![RubyGems.org](https://img.shields.io/badge/gem-rhetor-blue.svg)](https://www.rubygems.org/gems/rhetor)
[![Documentation](https://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/rhetor/frames)
[![License](https://img.shields.io/packagist/l/doctrine/orm.svg)](#license)

[![Dependency Status](https://gemnasium.com/edubenetskiy/rhetor.svg)](https://gemnasium.com/edubenetskiy/rhetor)
[![Coverage Status](https://img.shields.io/coveralls/edubenetskiy/rhetor.svg)](https://coveralls.io/r/edubenetskiy/rhetor?branch=master)
[![Build Status](https://api.travis-ci.org/edubenetskiy/rhetor.svg?branch=master)](https://travis-ci.org/edubenetskiy/rhetor)
[![Code Climate](https://codeclimate.com/github/edubenetskiy/rhetor/badges/gpa.svg)](https://codeclimate.com/github/edubenetskiy/rhetor)
[![Gem Version](https://badge.fury.io/rb/rhetor.svg)](https://github.com/edubenetskiy/rhetor/releases)


Rhetor is yet another lexical analyser library written in pure Ruby
with no runtime dependencies. It is properly documented and easy-to-use.

## Resurgence of Rhetor

**The project is staying alive!** In a week or two a brand-new version of Rhetor
will be eventually released. Single-phase *syntactic analysis* with feature-rich
but simple API is coming soon. Keep in touch!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rhetor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rhetor

## Usage

```ruby
# Define behaviour
lexer = Rhetor::LexicalAnalyser.new do
  # Within this block you can define your own rules, your own patterns
  # to recognize. You can call these methods out of this block
  # like this: lexer.rule(...), it also works.
  rule '+', :plus
  rule '-', :minus
  rule '*', :asterisk
  rule '/', :solidus
  rule '(', :left_parenthesis
  rule ')', :right_parenthesis

  # This rule will return tokens with floating-point values.
  # Actually, you can make Rhetor to return tokens with any types of values,
  # you only have to provide an evaluator - a block which receives a matched
  # substring and returns the desired value. Like here:
  rule(/[-+]?[0-9]*\.?[0-9]+/, :number) { |string| string.to_f }

  # Here we make Rhetor to ignore whitespaces via the regular expression:
  ignore(/\s+/)
  # We could also do it with a string: ignore ' ',
  # but regular expressions are more powerful.
end

# Analyse method returns an array of tokens. You can provide a block
# and it will be run for each of encountered tokens.
tokens = lexer.analyse('2 + 2 * 2 - (25 / (3 + 70 / 4))') do |token|
  puts token
end
# It produces:
# (number: 2.0 [0,1])
# (plus: "+" [2,1])
# (number: 2.0 [4,1])
# (asterisk: "*" [6,1])
# (number: 2.0 [8,1])
# (minus: "-" [10,1])
# (left_parenthesis: "(" [12,1])
# (number: 25.0 [13,2])
# (solidus: "/" [16,1])
# (left_parenthesis: "(" [18,1])
# (number: 3.0 [19,1])
# (plus: "+" [21,1])
# (number: 70.0 [23,2])
# (solidus: "/" [26,1])
# (number: 4.0 [28,1])
# (right_parenthesis: ")" [29,1])
# (right_parenthesis: ")" [30,1])

# Now get information about any of the tokens:
token = tokens.first # => (number: 2.0 [0,1])
token.value          # => 2.0
token.name           # => :number
token.position       # => 0
token.length         # => 1
```

## Contributing

1. Fork it (https://github.com/edubenetskiy/rhetor)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
Rhetor © 2015 by Egor Dubenetskiy. Rhetor is licensed under the MIT license. Please see LICENSE.txt for further details.
