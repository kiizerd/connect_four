# frozen_string_literal: true
require_relative 'connector'

class GameBoard
  attr_reader :board

  def initialize
    @board = make_board
    @connector = Connector.new
  end

  # returns move / false if position taken
  def check_move(move)
    check = @board[-1][move - 1] == ' '
    check ? move : check_column(move - 1)
  end

  # returns first open row / false if column full
  def check_column(col)
    @board[0..-2].map { |r| r[col] }.each_with_index do |pos, ind|
      return ind + 2 if pos == ' '
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
