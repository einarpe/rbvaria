#!/usr/bin/env ruby

class Atom
  attr_accessor :symbol
end

class Particle
  
  def initialize()
    @atoms = []
    @multiplier = 1
    @subparticles = []
  end

  def <<(object)
    if object.is_a? Atom 
      @atoms << object
    elsif object.is_a? Particle
      @subparticles << object
    end
      
  end
end

class ParticleParser

  def initialize(input)
    @input = input.strip.scan(/\b[A-Z][a-z]?\b|[0-9]+|\(|\{|\[|\]|\}|\)/)

    @parent = Particle.new
    @ast = @parent
  end

  def next_token
    @input.shift
  end

  def parse()
    while token = next_token()
      case token
        when /[0-9]+/ then parse_number(token)
        when /\b[A-Z][a-z]?\b/ then parse_atom(token)
        when /\(|\{|\[|\]|\}|\)/ then parse_bracket(token)
      end
    end
    @ast
  end

end