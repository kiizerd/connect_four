# frozen_string_literal: true

class Player

  attr_reader :shape

  @@shapes = ['O', 'X']

  def initialize
    @shape = @@shapes.pop
  end
  
  def get_col_choice
    move = rand(0..6)
  end
end

class Human < Player
  def get_col_choice
    user_input(1, 7)
  end
end

class Comp < Player

end
