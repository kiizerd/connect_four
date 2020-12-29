require_relative 'player'

class Game

  def initialize
    make_board
    get_players 1
  end

  def player_input(min, max) # loops until input inside range
    input = gets.chomp.to_i
    until verify_input(input, min, max)
      input = gets.chomp.to_i
    end
    input
  end

  def verify_input(input, min, max) # returns input / false if outside range
    return input >= min && input <= max ? input : false 
  end

  def get_moves # returns each players #make_move
    moves = @players.map { |player| player.make_move }    
    moves
  end

  def check_move(move) # returns move / false if position taken
    check = @board[-1][move - 1] == ' '
    return check ? move : check_column(move - 1)
  end

  def check_column(col) # returns true / false if column full
    @board[0..-2].map { |r| r[col] }.each_with_index do |pos, ind|
      return ind + 2 if pos == ' '
    end
    false
  end

  private

  def make_board # returns empty 7x7 grid / 2d-array
    @board = []
    7.times do |i|
      @board << []
      7.times do |j|
        @board[i] << ' '
      end
    end
    @board
  end            # resets @board instance variable
  
  def get_players(humans=nil) # returns array of new Players 
    @players = []
    count = humans.nil? ? player_input(0, 2) : humans
    count.times { @players << Human.new(self) }
    (2 - count).times { @players << Comp.new(self) }
    @players
  end                         # resets @players instance variable
end