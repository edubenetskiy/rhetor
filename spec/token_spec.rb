require 'spec_helper'

describe Rhetor do
  describe Token do
    describe '#to_s' do
      it 'returns a string representation of the token' do
        expect(
          Token.new('value', :name, 0, 42).to_s
        ).to eq '(name: "value" [0,42])'
      end
    end
  end
end
