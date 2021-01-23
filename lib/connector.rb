class Connector
  def initialize(gameboard)
    @board = gameboard
    @called = 0
  end

  def found 
    false
  end

  # sets root at
  def find_4(move)
    column = move - 1
    row = @board.check_column(move) + 1

    root = [row, column]

    return false
    check_adjacent(root)
  end
end