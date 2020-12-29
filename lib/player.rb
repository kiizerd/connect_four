class Player

  def initialize(game)
    @game = game
  end

  def make_move
    move = (rand 6) + 1
    return @game.check_move(move) ? move : false
  end
end

class Human < Player

end

class Comp < Player
  
end
