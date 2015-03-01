module Rhetor
  # Token class represents tokens matched from the input.
  #
  # @attr_reader [Object] value the value of the token
  # @attr_reader [Symbol] name the name of the matched rule
  # @attr_reader [Integer] position the position of the matched substring
  # @attr_reader [Integer] length the length of the matched substring
  #
  Token = Struct.new :value, :name, :position, :length do
    def to_s
      "(#{name}: #{value.inspect} [#{position},#{length}])"
    end

    alias_method :inspect, :to_s
  end

  EOF_TOKEN = Token.new(nil, nil, -1, nil)
end
