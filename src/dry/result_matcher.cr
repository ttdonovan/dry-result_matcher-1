require "./result_matcher/*"

module Dry::ResultMatcher
  def self.match(result : T, &block)
    yield(Matcher.new(result))
  end
end
