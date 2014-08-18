#!/usr/bin/env ruby

class Node
  attr_accessor :name, :children

  def initialize(name)
    @name = name || ""
    @children = []
  end

  def <<(node)
    @children << node
  end

  def to_s()
    @children.length > 0 ?
      "[#{@name}: #{@children.join(",")}]" :
      "[#{@name}]"
  end
end



class SimpleTreeParser

  attr_reader :ast

  def initialize(input)
    @tokens = input.strip.scan(/\b[a-z\s]+\b|,|\(|\)/i)
    @parent = Node.new("ROOT")
    @current = Node.new("")
    @old_parent = []
    @ast = @parent
  end

  def next_token()
    @tokens.shift
  end

  def parse()
    while token = next_token()
      case token
        when "," then parse_comma()
        when "(" then parse_left_bracket()
        when ")" then parse_right_bracket()
        else parse_node(token)
      end
    end
    @ast
  end

  def parse_comma()
    @current = new_node()
  end

  def parse_left_bracket()
    @old_parent.push(@parent)
    @parent = @current
    @current = new_node()
  end

  def parse_right_bracket()
    @parent = @old_parent.pop
    @current = new_node()
  end

  def parse_node(token)
    @current.name = token.strip
    @parent << @current
  end

  def new_node()
    Node.new("")
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
    print "\n\n--------------------result is #{result.to_s}\n\n-------------"
  end

  def test_parse2()
    stp = SimpleTreeParser.new("A, B(C, D, E), F, G")
    result = stp.parse
    print "\n\n--------------------result is #{result.to_s}\n\n-------------"
  end

  def test_parse2()
    stp = SimpleTreeParser.new("Ala(Ma(Kota(Oraz(Trzy(Psy), Serio))))")
    result = stp.parse
    print "\n\n--------------------result is #{result.to_s}\n\n-------------"
  end

end