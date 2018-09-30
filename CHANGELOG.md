# Change log

## master (unreleased)

## 0.2.0 (2018-09-30)

No changes. This release was intented just to re-upload the gem to Rubygems.org.

## 0.1.0 (2015-01-06)

### New features

* You can provide a block for LexicalAnalyser#analyse method and it will be run with each of encountered tokens.
* Tokens have values instead of corresponding substrings. You can provide an evaluator for any rule. It is a block that will be called if the pattern is encountered. It should receive a matched substring and return the value of the corresponding token. If the evaluator is omitted, the value of the token will coincide with the matched substring.
* Tokens can be represented as a string via to_s method

### Changes

* Update example in README.md

### Bugs fixed

* Fix Rake task `test:coverage'
