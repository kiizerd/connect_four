# frozen_string_literal: true

class Player
  def initialize(game)
    @game = game
  end

  # returns move / false if taken
  def make_move
    move = (rand 6) + 1
    @game.board.check_move(move) ? move : false
  end
end

class Human < Player
end

class Comp < Player
end
