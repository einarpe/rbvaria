
class JSONParser

  def self.get_parser(sth)
    raise "Don't know what to do!" if sth == nil

    case sth.class
      when String then return JSONStringParser.new(sth)
      else return JSONObjectParser.new(sth)
    end
  end


  def parse()
    raise "Abstract method called"
  end

end
