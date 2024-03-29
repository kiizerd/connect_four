# frozen_string_literal: true

class Player

  attr_reader :shape

  def initialize shape
    @shape = shape
  end

  def move
    get_col_choice
  end
  
  def get_col_choice
    move = rand(0..6)
  end
end

class Human < Player
  def to_s
    "Human"
  end
end

class Comp < Player
  def to_s
    "Comp"
  end
end
