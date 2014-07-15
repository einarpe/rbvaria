# random password generator
# based on list of words
# it combines some random words to one word, which becomes password
# @author kubar3k

class Password
  
  # constructor
  # load it up
  # 
  def initialize(dict_file_name, word_count)
    @word_count = word_count
    @file_contents = IO.readlines(dict_file_name)
    @total_lines_number = @file_contents.length - 1
  end
  
  # get random lines
  # resulting array containing completely random line numbers
  def get_random_lines(total_lines_number, how_many)
    result = []
    loop {
      result << (rand() * total_lines_number).floor  
      
      # break when result array is full enough
      break if result.length == how_many
    }
    return result
  end
  
  def generate()
    chosen_lines = get_random_lines(@total_lines_number, @word_count)
    result = ""
    
    chosen_lines.each { |line|
      result += normalize_word(@file_contents[line])
    }
    
    # append some number to resulting password
    result += (rand() * 10).floor.to_s
    return result
  end
  
  # remove non-alpha characters and line endings from word
  # make first charater uppercase
  # so resulting password will be CamelCase
  def normalize_word(word)
    word.gsub!(/[\r\n]+/, "")
    word[0] = word[0].upcase
    
    return word
  end
  
  
  private :get_random_lines, :load, :normalize_word
end

def cl_parse_options()
  $Options = { :dict_file_name => "dict.txt", :word_count => 3, :continous => false }
  loop {
    case ARGV[0]
      when '-f' then ARGV.shift; $Options[:dict_file_name] = ARGV.shift
      when '-c' then ARGV.shift; $Options[:word_count] = ARGV.shift.to_i
      when '-g' then ARGV.shift; $Options[:continous] = true
      else break
    end
  }
end

if ARGV.length > 0
  
    cl_parse_options
    
    pwd = Password.new($Options[:dict_file_name], $Options[:word_count])
    loop {
      begin
        print "#{pwd.generate}\n"
        $stdin.gets.chomp if $Options[:continous] == false
      rescue Exception => e
        exit
      end
    }
  
end