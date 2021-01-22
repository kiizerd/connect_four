# frozen_string_literal: true

class Player

  attr_reader :shape

  @@shapes = ['O', 'X']

  def initialize(board)
    @board = board
    @shape = @@shapes.pop
  end

  # returns move / false if taken
  def make_move
    move = (rand 7) + 1
    if @board.check_column(move)
      @board.apply_move(move, self)
    end
    move
  end
end

class Human < Player

end

class Comp < Player

end
