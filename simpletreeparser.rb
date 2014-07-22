#!/usr/bin/env ruby

class Node
  attr_accessor :value

  def initialize(value)
    @value = value
  end
end



class SimpleTreeParser
  def initialize(input)
    @tokens = input.strip.scan(/\b[a-z\s]+\b|,|\(|\)/i)
  end

  def next_token()
    @tokens.shift
  end

  def parse()
    token = next_token
    case token
      when nil then 
        result = nil
      when "(" then 
        result = parse
        raise "Bad parenthesis" unless next_token == ")"
      when "," then
        result = [result, parse]
      else
        result = token
    end

    return result
  end

end


require 'test/unit'

class TestParser < Test::Unit::TestCase

  def test_next_token()
    stp = SimpleTreeParser.new("( )AA,B B,G(H,)  ")
    actual = []
    expected = ["(", ")", "AA", ",", "B B", ",", "G", "(", "H", ",", ")"]
    while (token = stp.next_token)
      actual << token
    end
    assert_equal(actual, expected, "read tokens are not correct")
  end

  def test_parse()
    stp = SimpleTreeParser.new("A, B, C, D")
    result = stp.parse
    print "result is #{result}\n"
  end
end