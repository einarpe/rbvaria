#!/usr/bin/env ruby

class TorusString 

  def initialize(str)
    @str = str
  end

  def to_s
    @str
  end

  def each(&block)
    if block_given?
      @str.length.times do |i|
        yield @str[i], i
      end
    end
  end

  def [](obj)
    if obj.is_a? Range
      return substring(obj.first, obj.last)
    else
      obj = obj.to_i
      return substring(obj, obj)
    end
  end



  def substring(a, b)
    return nil if @str.length == 0

    if b == a
      return @str[a]
    elsif b < a
      return @str[a .. @str.length] + @str[0 .. b]
    else
      return @str[a .. b]
    end
      
  end
end


ts = TorusString.new("ala ma kota")
ts.each do |character, position|
  print "char of index #{position}+12 is #{ts[position + 12]}\n"
end

print "substring ... #{ts[8..2]}\n"





