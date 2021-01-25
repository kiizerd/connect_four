class Connector

  attr_reader :board

  def initialize(gameboard)
    @board_obj = gameboard
    @board = gameboard.board
  end

  def found 
    false
  end

  def start_path(move)
    root = node_from_move(move)
    @queue = get_possibles(root)

    for node in @queue do
      next_node(node[0], node[1])
    end
  end

  def next_node(dir, node)
    p "Direction: #{dir}"
    p "Shape :    #{@board[node.first][node.last]}"
    p "Node:      #{node}"
  end

  def get_possibles(node)
    row, col = node.first, node.last
    potentials = {up_left: [row + 1, col - 1], up_right: [row + 1, col + 1],
                  down_right: [row - 1, col + 1], down_left: [row - 1, col - 1],
                  up: [row + 1, col], down: [row - 1, col],
                  right: [row, col + 1], left: [row, col - 1]}
    adjacent = potentials.reject { |d, n| check_bounds(n) }
    possibles = adjacent.reject { |d, n| check_shape(node, n) }
  end

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
    col, row = move - 1, -(@board_obj.check_column(move))
    row == 1 ? row = 0 : row -= 2
    [row, col]
  end
end