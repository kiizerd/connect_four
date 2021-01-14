# frozen_string_literal: true
require_relative 'connector'

class GameBoard
  attr_reader :board

  def initialize
    @board = make_board
    @connector = Connector.new
  end

  # called by game class, for each players move
  def apply_move(move, player)
    row = check_column(move)
    @board[row][move - 1] = player.shape
  end

  # returns first open row / false if column full
  def check_column(col)
    @board.reverse.each_with_index do |row, i|
      return -(i + 1) if row[col - 1] == " "
    end
    false
  end

  # generates empty grid
  def make_board
    Array.new(6) { Array.new(7, ' ') }
  end

  def game_over(winner)
    puts "#{winner} has won!"
  end
end
