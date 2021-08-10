# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'display'
require_relative 'connector'

# main game functionality
class Game

  def initialize
    @board = GameBoard.new
    @players = [Player.new, Player.new]
    @connector = Connector.new(@board)
  end

  def start
    p1, p2 = @players.first, @players.last
    current = p1
    42.times do |i|
      col = current.get_col_choice
      @board.apply_move(col, current) if @board.check_column(col)
      break if @connector.found
      current = current == p1 ? p2 : p1
    end
    game_over
  end
  
  def user_input(min, max, player=@players.first)
    puts "Input a number between #{min} and #{max}"
    input = gets.chomp.to_i
    input = gets.chomp.to_i until verify_input(input.to_i, min, max)
    input
  end

  private

  def verify_input(input, min, max)
    input >= min && input <= max ? input : false
  end
  
  def game_over(winner=nil)
    puts "#{winner} wins"
  end
end
