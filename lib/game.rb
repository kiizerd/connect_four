require_relative 'player'

class Game

  def initialize
    make_board
    get_players
  end

  def player_input(min, max) ##
    input = gets.chomp.to_i
    until verify_input(input, min, max)
      input = gets.chomp.to_i
    end
    input
  end

  def verify_input(input, min, max)
    return input >= min && input <= max ? input : false 
  end

  def get_moves
    moves = @players.map { |player| player.make_move }    
    moves
  end

  def make_board
    @board = []
    7.times do |i|
      @board << []
      7.times do |j|
        @board[i] << ' '
      end
    end
    @board
  end
  
  def get_players(count=nil)
    @players = []
    count = player_input(0, 2) unless count
    count.times { @players << Human.new(self) }
    (2 - count).times { @players << Comp.new(self) }
    @players
  end
end
