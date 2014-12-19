#!/usr/bin/env ruby

# http://www.codewars.com/kata/fluent-calculator

def symb_to_value(symb)
  case symb
    when :one then return 1
    when :two then return 2
    when :three then return 3
    when :four then return 4
    when :five then return 5
    when :six then return 6
    when :seven then return 7
    when :eight then return 8
    when :nine then return 9
    when :ten then return 10
    when :zero then return 0
    else return nil
  end
end

class Number

  def initialize(value)
    @value = value
  end
  
  def method_missing(name, *args, &block)
    return Operation.new(name, @value)
  end

  def to_s()
    return @value.to_s
  end
end

class Operation
  
  def initialize(oper_kind, operand)
    @oper_kind = oper_kind
    @operand = operand
  end

  def method_missing(name, *args, &block)
    a_value = @operand
    b_value = symb_to_value(name)
    return oper(a_value, b_value)
  end

  def oper(a, b)
    case @oper_kind
      when :plus then return a + b
      when :minus then return a - b
      when :times then return a * b
      when :divided_by then return a / b
    end
  end

  def to_s
    return "[" + @oper_kind.to_s + ", " + @operand.to_s + "]"
  end
end

class Calc 
  def method_missing(name, *args, &block)
    return Number.new(symb_to_value(name))
  end
end


def main(argv)
  a = argv[0].to_sym
  method = argv[1].to_sym
  b = argv[2].to_sym

  result = Calc.new.send(a).send(method).send(b)
  puts "#{result}"
  
end

main(ARGV) if ARGV.length == 3

