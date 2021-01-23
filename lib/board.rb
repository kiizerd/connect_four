# frozen_string_literal: true
require_relative 'connector'

class GameBoard
  include Display
  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
  end

  # called by each players move, sets given move in board array
  def apply_move(move, player)
    row = check_column(move)
    @board[row][move - 1] = player.shape
  end  

  def full?
    @board.flatten.reject(&:empty?).size == 42
  end

  def row_victory?

  end

  def col_victory?

  end

  def diag_victory?

  end

  def complete?

  end

  private

  def check_diagonal?(root, dir)
    diag = []
    row, col = root.first, root.last
    if dir == 1
      @board[row][col]
    elsif dir == 2

    elsif dir == 3

    elsif dir == 4

    end
  end
end
