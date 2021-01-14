# frozen_string_literal: true

class Player

  attr_reader :shape

  def initialize(board)
    @board = board
    @shape = 'O'
  end

  # returns move / false if taken
  def make_move
    move = (rand 7) + 1
    if @board.check_column(move)
      @board.apply_move(move, self)
    end
  end
end

class Human < Player

end

class Comp < Player

end
