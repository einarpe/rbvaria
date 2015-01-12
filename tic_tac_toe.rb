

:PLAYER_HUMAN = 1
:PLAYER_CPU = 10

class Game

  def initialize()
    @board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @moves_left = 9
  end

  def move(who, pos)
    raise "Game is over yet" if @moves_left == 0
    @board[pos] = who
    @moves_left -= 1
  end

  def over?
    return @moves_left == 0
  end

  def winner()
    winning = [
      @board[0] + @board[1] + @board[2],
      @board[3] + @board[4] + @board[5],
      @board[6] + @board[7] + @board[8],
      @board[0] + @board[3] + @board[6],
      @board[1] + @board[4] + @board[7],
      @board[2] + @board[5] + @board[8],
      @board[0] + @board[4] + @board[8],
      @board[2] + @board[4] + @board[6]
    ]

    while (check = winning.shift)
      return :PLAYER_CPU if check == 30
      return :PLAYER_HUMAN if check == 3
    end

  end

  def to_s()
    @board.each_index do |cell, i|
      str = "X" if cell == :PLAYER_HUMAN
      str = "O" if cell == :PLAYER_CPU
      print "|%s" % str
      print "|\r\n-------\r\n" if i > 0 && i % 3 == 0
    end
  end
end

def main()
  g = Game.new
end