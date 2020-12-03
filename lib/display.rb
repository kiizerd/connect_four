class Display

  attr_reader :board

  @@piece = "\u25CF".encode
  @@blue_piece = "\e[34m#{@@piece}\e[0m"
  def initialize
    @board = make_board
  end

  def make_board
    board = []
    for i in 1..15 do
      section = []
      if i == 1 or i == 15
        section << '|'
        section << ('=' * 35)
        section << '|\\'
      elsif i % 2 == 0
        section << '|'
        section << ("  #  " * 7)
        section << '|\\'
      else
        section << '|'
        section << ('-' * 35)
        section << '|\\'
      end
      board << section.join
    end
    board
  end

  def update(move)
    return false unless good_move?(move)
    move_ary = move.split('')
    move_row = move_ary.first.to_i
    move_column = move_ary.last.to_i

    row_ary = @board[(move_row * 2) - 1].split('')
    row_ary[((move_column - 1)* 5) + 3] = @@piece

    @board[(move_row * 2) - 1] = row_ary.join
    @board
  end

  def good_move?(move)
    move_ary = move.split('')
    move_row = move_ary.first.to_i
    move_column = move_ary.last.to_i
    return false if move_row < 1 or move_row > 7 or
                    move_column < 1 or move_column > 7 or
                    check(move) == @@piece
    return true
  end

  def check(pos)
    pos_row = pos.split('').first.to_i
    pos_column = pos.split('').last.to_i

    row_array = @board[(pos_row * 2) - 1].split('')
    mark = row_array[((pos_column - 1)* 5) + 3]
    puts mark
    mark
  end
end
