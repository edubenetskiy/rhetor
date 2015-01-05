# Rhetor

Rhetor is yet another lexical analyser library written in pure Ruby
with no runtime dependencies. It is properly documented and easy-to-use.

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
  rule '+', :plus
  rule '-', :minus
  rule '*', :asterisk
  rule '/', :solidus
  rule '(', :left_parenthesis
  rule ')', :right_parenthesis
  rule /[-+]?[0-9]*\.?[0-9]+/, :number
  ignore /\s+/
end

# Iterate through tokens
lexer.analyse('2 + 2 * 2 - (25 / (3 + 70 / 4))').each do |token|
  puts "#{token.name.to_s.rjust(20)}: #{token.string.center(3)} [#{token.position}]"
end

# It produces:
#               number:  2  [0]
#                 plus:  +  [2]
#               number:  2  [4]
#             asterisk:  *  [6]
#               number:  2  [8]
#                minus:  -  [10]
#     left_parenthesis:  (  [12]
#               number: 25  [13]
#              solidus:  /  [16]
#     left_parenthesis:  (  [18]
#               number:  3  [19]
#                 plus:  +  [21]
#               number: 70  [23]
#              solidus:  /  [26]
#               number:  4  [28]
#    right_parenthesis:  )  [29]
#    right_parenthesis:  )  [30]
```

## Contributing

1. Fork it (https://github.com/edubenetskiy/rhetor)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request