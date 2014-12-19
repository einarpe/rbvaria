

class SqlSpecificParser


  def parse(sql, column)
    @position = sql.index(column) 
    return "" if @position == nil

    @position -= 1
    @sql = sql
    @column = @column
    return parse_internal()
  end

  def parse_internal()
    skip_whitespace()
    skip_as_keyword()
    skip_whitespace()

    current = @sql[@position]
    if current != ")"
      return parse_simple()
    elsif current == ")"
      return parse_via_parenthesis()
    end

    return ""
  end

  def skip_whitespace()
    while @sql[@position] =~ /\s/
      @position -= 1
    end
  end

  def skip_as_keyword
    @position -= 2 if @sql[@position - 1] == "a" && @sql[@position] == "s"
  end

  def parse_simple()
    parsed = ""
    while @position > 0
      current_char = @sql[@position]
      is_whitespace = (current_char =~ /\s/)
      parsed = current_char + parsed if not is_whitespace

      break if is_whitespace
      @position -= 1
    end
    return parsed
  end

  def parse_via_parenthesis()
    parsed = ""
    level = 0
    while @position > 0
      current_char = @sql[@position]
      level += 1 if current_char == ")"
      level -= 1 if current_char == "("

      parsed = current_char + parsed if level >= 0

      break if level <= 0
      @position -= 1
    end
    return parsed
  end
    

end


