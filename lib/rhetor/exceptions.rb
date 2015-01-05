module Rhetor
  RhetorError = Class.new(StandardError)
  UnmatchedString = Class.new(RhetorError)
  InvalidRuleName = Class.new(RhetorError)
  RuleAlreadyExists = Class.new(RhetorError)
  InvalidPattern = Class.new(RhetorError)
  InvalidString = Class.new(RhetorError)
  NoStringLoaded = Class.new(RhetorError)
end
