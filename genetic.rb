#!/usr/bin/env ruby

# genetinc programming


# random number generator
class RND
  @@generator = Random.new
  
  def self.rand(range)
    return @@generator.rand(range)
  end
end

# chromosome
class Chromosome
  attr_accessor :value
  
  def initialize(value)
    @value = value
  end
  
  def mutate()
    @value += RND::rand(-1.0 .. 1.0)
  end
end

# let's do it!
class Genetic
  attr_reader :generation, :values
  attr_accessor :func

  def initialize(values_count, x_from, x_to)
    @generation = 1
    @x_from = x_from
    @x_to = x_to
    @values = populate(values_count)
  end

  def fit(x)
    return (0 - @func.call(x)).abs
  end

  def populate(length)
    rng = @x_from .. @x_to
    return Array.new(length) { |el| 
      el = Chromosome.new( RND::rand(rng) )
    }
  end
  
  # magic
  def next()
    
    @generation += 1
  end

end

# some sample how it works
g = Genetic.new(100, -11.0, 11.0)
g.func = lambda { |x| (-x ** 3) +4 * (x ** 2) + 3.0 * x - 1 }

loop {
  g.next
  break if g.generation >= 1000
}

print g.values

print "\n"