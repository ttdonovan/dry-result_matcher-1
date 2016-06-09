# require "dry-monads.cr/dry/monads/either"

module Dry::ResultMatcher
  class Matcher(T)
    getter result

    # TODO: @result should be a Dry::Monads::Either::Right or Dry::Monads::Either::Left
    def initialize(@result : T)
      # TODO: add unit test coverage for #to_either
      if (r = @result).responds_to?(:to_ether)
        @result = r.to_either
      end
    end

    def success(&block)
      if (r = result).responds_to?(:right?) && r.responds_to?(:right)
        return unless r.right?
        yield(r.right)
      end
    end

    def failure(&block)
      if (r = result).responds_to?(:left?) && r.responds_to?(:left)
        return unless r.left?
        yield(r.left)
      end
    end
  end
end
