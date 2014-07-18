# Random password generator.
# It is based on list of words
#   and combines some random words to one word, which becomes password.
# @author kubar3k

class Password
  attr_accessor :word_count, :max_length, :append_space
  
  # constructor
  # load it up
  def initialize(dict_file_name)
    @file_contents = IO.readlines(dict_file_name)
    @total_lines_number = @file_contents.length - 1
  end
  
  # Generator of one password.
  # Resulting string is of @max_length containing @word_count number of words. 
  # When @append_space is true, after each of word, but not last, is appended space character.
  def generate()
    pwd = ""
    current_count = 0
    
    while current_count < @word_count
      rand_line_no = get_random_line_no()
      word = normalize_word(@file_contents[rand_line_no])
      
      tmp_pwd = check_and_append(pwd, word)
      if tmp_pwd != pwd
        pwd = tmp_pwd
        current_count += 1
      end
    end
    return pwd
  end
  
  # remove non-alpha characters and line endings from word
  # make first charater uppercase
  # so resulting password will be CamelCase
  def normalize_word(word)
    word.gsub!(/[\r\n]+/, "")
    word[0] = word[0].upcase if !@append_space
    return word
  end
  
  # check if we don't exceed max length of password
  def check_and_append(password, word)
    tmp_pwd = password + word
    if tmp_pwd.length <= @max_length
      password += (@append_space && password.length > 0 ? " " : "") + word
    end
    return password
  end
  
  def get_random_line_no()
    return (rand() * @total_lines_number).floor
  end
  
  private :normalize_word, :get_random_line_no
end

def cl_parse_options()
  $Options = { :dict_file_name => "data/wordsEn.txt", :word_count => 3, :continous => false, :max_length => Float::INFINITY, :append_space => false }
  loop {
    case ARGV[0]
      when '-if' then ARGV.shift; $Options[:dict_file_name] = ARGV.shift
      when '-wc' then ARGV.shift; $Options[:word_count] = ARGV.shift.to_i
      when '-gen' then ARGV.shift; $Options[:continous] = true
      when '-len' then ARGV.shift; $Options[:max_length] = ARGV.shift.to_i
      when '-as'  then ARGV.shift; $Options[:append_space] = true
      else break
    end
  }
end

def main()
  cl_parse_options
      
  pwd = Password.new($Options[:dict_file_name])
  pwd.word_count = $Options[:word_count]
  pwd.max_length = $Options[:max_length]
  pwd.append_space = $Options[:append_space]

  loop {
    begin
      print "#{pwd.generate}\n"
      $stdin.gets.chomp if $Options[:continous] == false
    rescue Exception => e
      exit
    end
  }
end

main()