# frozen_string_literal: true
require_relative 'connector'

class GameBoard
  attr_reader :board, :connector

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @connector = Connector.new(self)
  end

  # called by each players move, sets given move in board array
  def apply_move(move, player)
    row = check_column(move)
    @board[row][move - 1] = player.shape
  end

# returns negative index of last found piece in move
  def check_column(move)
    @board.reverse.each_with_index do |row, i|
      return -(i + 1) if row[move - 1] == ' '
    end
    false
  end

end
