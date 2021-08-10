# frozen_string_literal: true
require_relative 'connector'

class GameBoard
  attr_reader :board, :last_node

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
  end

  def check_column(col)
    @board[0][col] == ' '
  end
  
  def apply_move(move, player)
    col = move
    row = get_next_row(col)
    @board[row][col] = player.shape
    @last_node = [-row - 1, col]
  end

  private

  def get_next_row(col)
    @board.reverse.each_with_index do |row, i|
      return -(i + 1) if row[col] == ' '
    end
    false
  end

end
