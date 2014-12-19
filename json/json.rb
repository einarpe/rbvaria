
require_relative 'jsonparser'
require_relative 'jsonstringparser'
# require_relative 'jsonobjectparser'

class JSON

  def self.parse(str)
    parser = JSONParser.get_parser(str)
    parser.parse
  end

  def self.stringify(obj)
    parser = JSONParser.get_parser(obj)
    parser.parse
  end

end

