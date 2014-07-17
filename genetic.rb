#!/usr/bin/env ruby
# encoding utf-8

# Genetic Programming
# Example of mutation: the best one are subject to mutation, the worst one are removed.
# We are trying to find one of some roots of given polynomial function. 

# Useful URL: http://www.geneticprogramming.com/Tutorial

# @author kubar3k

# Random number generator
class RNG
  @@generator = Random.new
  
  def self.rand(range)
    @@generator.rand(range)
  end
end

# Chromosome contains information about polynomial argument
class Chromosome
  attr_accessor :value
  
  def initialize(value)
    @value = value
  end
  
  # Mutation which means we add some random value to its initial value and return
  # new chromosome with new argument
  def mutate()
    Chromosome.new(@value + RNG::rand(-1.0 .. 1.0))
  end

  def to_s()
    "[" + ('%.4f' % @value) + "]"
  end
end

# let's do it!
# main class of program
class Genetic
  attr_reader :generation, :population
  attr_accessor :func
  
  # constructor
  # @param values_count number of chromosomes in population
  # @param x_from - left bound of range of arguments where we shall find zero of function
  # @param x_to - right bound of range of arguments etc. etc. 
  def initialize(values_count, x_from, x_to)
    @generation = 1
    @x_from = x_from
    @x_to = x_to
    @population = init_randomly(values_count)
  end
  
  # fitness function
  # just return absolute value of polynomial function with given argument 
  def fit(x)
    return (0 - @func.call(x)).abs
  end
  
  # 
  def init_randomly(length)
    x_range = @x_from .. @x_to
    return Array.new(length) { |el| 
        Chromosome.new( RNG::rand(x_range) )
    }
  end
  
  # compute fitness of each chromosome in population
  # resulting array is sorted by fitness of each chromosome
  def fitness_of_population()
    fitness = []
    
    # apply fit function
    @population.each_index { |i|
      c = @population[i]
      fitness << {
        :fit => fit(c.value),
        :idx => i
      }
    }
    
    # ascending sort by distance from x-axis
    fitness.sort! { |f1, f2|  f1[:fit] <=> f2[:fit]  }
    
    return fitness
  end
  
  # mutate the best chromosome
  def mutate_one(fitness_array)
    # get the best
    best = fitness_array[0]
    
    # mutate it
    new_one = @population[ best[:idx] ].mutate
    
    # add newly created mutant to population
    @population << new_one
  end
  
  # remove the worst chromosome, it is so useless...
  def remove_one(fitness_array)
    # get the worst
    worst = fitness_array[fitness_array.length - 1]
    
    # remove the one
    @population.delete_at( worst[:idx] )
  end

  # magic! ( ͡° ͜ʖ ͡°) 
  def next()
    fitness_array = fitness_of_population
    
    mutate_one(fitness_array)
    remove_one(fitness_array)
    
    @generation += 1
  end

end

# -------------------------------------------------------- #

# some sample how it works
g = Genetic.new(24, -11.0, 11.0)

# -x^3 +4x^2 +3x -1
g.func = lambda { |x| (-x ** 3) + 4 * (x ** 2) + 3.0 * x - 1 }

loop {
  g.next
  break if g.generation >= 1000
}

print g.population.sort { |c1, c2| 
  c1.value <=> c2.value
} .join("\n")

print "\n"