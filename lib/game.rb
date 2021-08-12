# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'display'
require_relative 'connector'

class Game

  def initialize
    @board     = GameBoard.new
    @players   = [Human.new('X'), Player.new('O')]
    @connector = Connector.new(@board)
  end

  def start
    p1, p2  = @players
    current = p1
    42.times do |i|
      try_move(current)
      break if @connector.found?
      current = current == p1 ? p2 : p1
    end
    game_over
  end

  def try_move player
    col = player.move
    if @board.check_column col
      @board.apply_move player 
      return true
    end
    return false
  end
  
  def user_input(min, max, player=@players.first)
    puts "Input a number between #{min} and #{max}"
    input = gets.chomp.to_i
    # TODO - Add a call to check input against some strings
    # that correspond to commands for the game i.e - exit, restart, stats
    input = gets.chomp.to_i until verify_input(min, max, input)
    input
  end

  def verify_input(min, max, input)
    input >= min && input <= max ? input : false
  end
  
  def game_over(winner=nil)
    puts "#{winner} wins"
  end
end
