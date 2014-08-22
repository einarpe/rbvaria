#!/usr/bin/env ruby 

class String

  def two_char_iterator()
    previous = nil
    self.each_char { |current|
      yield previous, current
      previous = current
    }
  end

end


"zaswmnbvgu".two_char_iterator() do |prev, curr|
  tc = [prev, curr]
  print "#{tc.join(' ')}\n"
end



