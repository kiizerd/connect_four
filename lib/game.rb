# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'display'
require_relative 'connector'

# main game functionality
class Game
  attr_reader :board, :connector, :players

  def initialize
    @board = GameBoard.new
    make_players 1
  end

  def start
    p1, p2 = @players.first, @players.last
    current = p1
    42.times do |i|
      move = current.make_move
      break if @board.connector.found(move)
      binding.pry
      current = current == p1 ? p2 : p1
    end
    game_over
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

  # returns array of new Players
  def make_players(humans=nil)
    @players = []
    count = humans.nil? ? player_input(0, 2) : humans
    count.times { @players << Human.new(self.board) }
    (2 - count).times { @players << Comp.new(self.board) }
    @players
  end

  private

  def game_over(winner=nil)
    puts "#{winner} wins"
  end
end
