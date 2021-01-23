# frozen_string_literal: true
require_relative 'connector'

class GameBoard
  attr_reader :board, :connector

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @connector = Connector.new(@board)
  end

  # called by each players move, sets given move in board array
  def apply_move(move, player)
    row = check_column(move)
    @board[row][move - 1] = player.shape
  end

  def check_column(col)
    @board.reverse.each_with_index do |row, i|
      return -(i + 1) if row[col - 1] == ' '
    end
    false
  end

end
