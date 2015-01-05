module Rhetor
  # Token class represents tokens matched from the input.
  #
  # @attr_reader [String] string the part of string that was encountered
  # @attr_reader [Symbol] name the name of the matched rule
  # @attr_reader [Integer] position the position of the substring
  # @attr_reader [Integer] length the length of the substring
  #
  Token = Struct.new :string, :name, :position, :length

  EOF_TOKEN = Token.new(nil, nil, -1, nil)

  # LexicalAnalyser is a class that performs lexical analysis
  # of strings using a set of predefined rules.
  #
  # @!attribute [r] string
  #   @return [String] the string being analyzed
  # @!attribute [r] position
  #   @return [Integer] the current position of analyser
  #
  # @author Egor Dubenetskiy <edubenetskiy@ya.ru>
  #
  class LexicalAnalyser
    attr_reader :string, :position

    # Creates a new lexical analyser and evaluates the passed block within it
    # @param &block [Block] the block to be executed
    # @example Creating a simple HQ9+ parser
    #   lexer = Rhetor::LexicalAnalyser.new {
    #     rule 'H', :hello_world
    #     rule 'Q', :quine
    #     rule '9', :ninety_nine_bottles
    #     rule '+', :increment
    #     ignore /\s+/
    #   }
    # @return [void]
    #
    def initialize(&block)
      @string_patterns = {}
      @regexp_patterns = {}
      @ignored = []
      @used_names = []
      @string = nil
      @position = nil
      if block_given?
        block.arity == 1 ? block.call(self) : instance_eval(&block)
      end
    end

    # Makes the analyser to recognize some pattern
    # @param pattern [String, Regexp] the pattern
    # @param name [Symbol] the name of the rule
    # @raise [InvalidPattern] if the pattern is not valid
    # @raise [InvalidRuleName] unless the name of the rule is a symbol
    # @raise [RuleAlreadyExists] if the rule with the same name already exists
    # @return [void]
    #
    def rule(pattern, name)
      fail InvalidPattern unless [String, Regexp].include? pattern.class
      fail InvalidRuleName unless name.is_a? Symbol
      fail RuleAlreadyExists if @used_names.include? name
      @used_names.push name
      array_name = "@#{pattern.class.name.downcase}_patterns".intern
      instance_variable_get(array_name)[name] = pattern
    end

    # Makes the analyser to ignore some pattern
    # @param pattern [String, Regexp] the pattern to be ignored
    # @return [void]
    #
    def ignore(pattern)
      fail InvalidPattern unless [String, Regexp].include? pattern.class
      @ignored.push pattern unless @ignored.include? pattern
    end

    # Initiates the analysis of the string
    # @param string [String] the string to be analyzed
    # @return [void]
    #
    def begin_analysis(string)
      fail InvalidString unless string.is_a? String
      @string = string
      @position = 0
      @size = string.size
    end

    # @return [Token] the next token found in the string
    # @raise [NoStringLoaded] if no string is being analyzed
    # @raise [UnmatchedString] if the analyser is unable to get the next token
    #
    def next_token
      fail NoStringLoaded unless @string
      @position = skip_ignored(@string, @position)
      return EOF_TOKEN if @position >= @size
      name, length = string_pattern(@string, @position)
      name, length = regexp_pattern(@string, @position) if length == 0
      fail UnmatchedString, "at position #{@position}" if length == 0
      token = Rhetor::Token.new(@string[@position, length],
                                name, @position, length)
      @position += length
      token
    end

    # Analyzes the given string
    # @param string [String] the string to be analyzed
    # @return [Array<Token>] the array of encountered tokens
    #
    def analyse(string)
      begin_analysis(string)
      tokens = []
      loop do
        last_token = next_token
        (last_token == EOF_TOKEN) ? break : tokens << last_token
      end
      tokens
    end

    private

    def string_pattern(string, position)
      results = @string_patterns.map do |name, pattern|
        [name, matched_size(pattern, string, position)]
      end
      results.max_by(&:last) || [nil, 0]
    end

    def regexp_pattern(string, position)
      results = @regexp_patterns.map do |name, pattern|
        [name, matched_size(pattern, string, position)]
      end
      # results.max_by(&:last) || [nil, 0]
      results.sort_by(&:last).find { |_name, size| size > 0 } || [nil, 0]
    end

    def skip_ignored(string, position)
      skipped = @ignored.map { |p| matched_size(p, string, position) }.max
      skipped ? position + skipped : position
    end

    def matched_size(pattern, string, position)
      case pattern
      when String
        (string[position, pattern.size] == pattern) ? pattern.size : 0
      when Regexp
        md = string.match(pattern, position)
        return 0 unless md
        md.begin(0) == position ? md[0].size : 0
      end
    end
  end
end
