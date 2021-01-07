# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'display'
require_relative 'connector'

# main game functionality
class Game
  attr_reader :board

  def initialize
    @board = GameBoard.new
    get_players 1
  end

  # loops until input inside range
  def player_input(min, max, player=@players.first)
    puts "input a number"
    input = gets.chomp.to_i
    input = gets.chomp.to_i until verify_input(input.to_i, min, max)
    input
  end

  # returns input / false if outside range
  def verify_input(input, min, max)
    input >= min && input <= max ? input : false
  end

  # returns each players #make_move
  def players_moves
    @players.map(&:make_move)
  end

  # returns array of new Players
  def get_players(humans = nil)
    @players = []
    count = humans.nil? ? player_input(0, 2) : humans
    count.times { @players << Human.new(self) }
    (2 - count).times { @players << Comp.new(self) }
    @players
  end
end
