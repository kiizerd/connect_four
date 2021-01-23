class Connector

  attr_reader :board

  def initialize(board)
    @board = board
  end

  def found 
    false
  end

  def start_path(move)
    root = node_from_move(move)
    check_adjacent(root)
  end

  def check_adjacent(node)
    x, y = node.first, node.last
    potentials = {down_right: [x + 1, y + 1], up_right: [x + 1, y - 1],
                  down_left: [x - 1, y + 1], up_left: [x - 1, y - 1],
                  right: [x + 1, y], left: [x - 1, y],
                  down: [x, y + 1], up: [x, y - 1]}
    adjacent = potentials.reject { |d, n| check_bounds(n) }.values
    possibles = adjacent.reject { |n| check_shape(node, n) }
  end

  private

  def check_bounds(node)
    row, col = node.first, node.last
    return true if row > 5 || row < 0
    return true if col > 6 || col < 0
    return false
  end

  def check_shape(root, current)
    shape = @board.reverse[root.first][root.last]
    return false if @board.reverse[current[0]][current[1]] == shape
    return true
  end

  def node_from_move(move)
    col, row = move - 1, @board.check_column(move) - 1
    node = [row, column]
  end
end