

:PLAYER_HUMAN = 1
:PLAYER_CPU = 10

class TicTacToeGame
  attr_reader :board

  def initialize()
    @board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @moves_left = 9
  end

  def move(player, pos)
    raise "Game is over yet" if @moves_left == 0
    @board[pos] = player
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

    return :PLAYER_HUMAN if winning.index(3) != nil
    return :PLAYER_CPU if winning.index(30) != nil
  end

  def to_s()
    @board.each_index do |i|
      cell = @board[i]
      str = "X" if cell == :PLAYER_HUMAN
      str = "O" if cell == :PLAYER_CPU
      print "|%s" % str
      print "|\r\n-------\r\n" if i > 0 && i % 3 == 0
    end
  end
end

def minimax(game, player)
  
end


def main()
  g = TicTacToeGame.new
end