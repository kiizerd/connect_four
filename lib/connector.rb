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
    @queue = get_possibles(root)
  end

  def next_node(dir, node)

  end

  def get_possibles(node)
    row, col = node.first, node.last
    potentials = {up_left: [row + 1, col - 1], up_right: [row + 1, col + 1],
                  down_left: [row - 1, col + 1], down_right: [row - 1, col - 1],
                  up: [row + 1, col], down: [row - 1, col],
                  right: [row, col + 1], left: [row, col - 1]}
    pp potentials
    adjacent = potentials.reject { |d, n| check_bounds(n) }
    possibles = adjacent.reject { |d, n| check_shape(node, n) }
  end

  private

  def check_bounds(node)
    row, col = node.first, node.last
    return true if row > 5 || row < 0
    return true if col > 6 || col < 0
    return false
  end

  def check_shape(node, current)
    shape = @board.reverse[node.first][node.last]
    return false if @board.reverse[current[0]][current[1]] == shape
    return true
  end

  def node_from_move(move)
    col, row = move - 1, @board.check_column(move) - 1
    node = [row, column]
  end
end