require 'spec_helper'

describe Rhetor do
  describe LexicalAnalyser do
    subject('analyser') do
      described_class.new do |t|
        t.rule 'key', :key
        t.rule 'keyword', :keyword
        t.rule 'word', :word
      end
    end

    it 'returns an empty array being called with an empty string' do
      expect(analyser.analyse('')).to eq []
    end

    it 'returns an empty array if ignores anything' do
      analyser.ignore(/.+/)
      expect(analyser.analyse('something anything')).to eq []
    end

    it 'does not recognize an improper string' do
      expect { analyser.analyse 'something' }.to raise_error(UnmatchedString)
    end

    it 'recognizes a single keyword' do
      expect(analyser.analyse('word')).to eq [Token.new('word', :word, 0, 4)]
      expect(analyser.analyse('key')).to eq [Token.new('key', :key, 0, 3)]
    end

    it 'recognizes a single pattern' do
      analyser.rule(/\w+/, :custom_word)
      expect(analyser.analyse('something')).to eq \
        [Token.new('something', :custom_word, 0, 9)]
    end

    it 'recognizes a sequence of patterns and keywords' do
      analyser.rule(/\w+/, :custom_word)
      analyser.ignore(/\s+/)
      expect(analyser.analyse('some word')).to eq \
        [Token.new('some', :custom_word, 0, 4),
         Token.new('word', :word, 5, 4)]
    end

    it 'takes only the longest token of several overlapped tokens' do
      expect(analyser.analyse('keyword')).to eq \
        [Token.new('keyword', :keyword, 0, 7)]
    end

    it 'recognizes several consecutive keywords' do
      expect(analyser.analyse('wordkeykeyword')).to eq \
        [Token.new('word', :word, 0, 4),
         Token.new('key', :key, 4, 3),
         Token.new('keyword', :keyword, 7, 7)]
    end

    it 'forbids the creation of rules with identical names' do
      expect do
        analyser.rule('key', :key)
      end.to raise_error(RuleAlreadyExists)
    end

    it 'checks the validity of the names of the rules' do
      expect do
        analyser.rule('something', 'invalid rule name')
      end.to raise_error(InvalidRuleName)
    end

    it 'checks the validity of the pattern' do
      expect do
        analyser.rule(:invalid_rule_pattern, :invalid_rule)
      end.to raise_error(InvalidPattern)
    end

    it 'skips specified patterns' do
      analyser.ignore(/\s+/)
      expect(analyser.analyse('word key keyword')).to eq \
        [Token.new('word', :word, 0, 4),
         Token.new('key', :key, 5, 3),
         Token.new('keyword', :keyword, 9, 7)]
    end

    it 'executes a passed block' do
      expect do |b|
        analyser.analyse('wordkeykeyword', &b)
      end.to yield_successive_args(Token.new('word', :word, 0, 4),
                                   Token.new('key', :key, 4, 3),
                                   Token.new('keyword', :keyword, 7, 7))
    end
  end
end
