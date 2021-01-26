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
    p "-- Starting path --"
    root = node_from_move(move)
    p "node: #{root}"

    @queue = get_possibles(root)
    p @queue
    path_from_node root

    false
  end
  
  def path_from_node(root)
    path = [['root' => root]]
    possibles = @queue.clone
    until possibles.empty?
      dir = possibles.keys[0]
      next_node = possibles[possibles.keys[0]]
      p "dir: #{dir}"

      current = [dir, next_node]

      search_forward(current[0], current[1])

      possibles.shift
    end
  end

  def search_forward(dir, node)
    path = []
    nodes = next_nodes(dir,node)
    p "nodes size #{nodes.size}"
    p nodes
    p "#{node} -#{dir}-> #{nodes.first}:#{nodes.last}"
  end

  def search_backward(dir, node)
    opposites = { "down_left" => 'up_right', "down_right" => "up_left",
                  "up_left" => "down_right", "up_right" => "down_left",
                  'right' => 'left', 'left' => "right",
                  'up' => "down", 'down' => "up" }
    nodes = next_nodes(opposites[dir], node)                  
  end

  def next_nodes(dir, node)
    p "getting #{node}'s next node"
    p "in #{dir} direction"
    get_linear(dir, node).each do |d, next_node|
      p "Next node: #{next_node} dir: #{d}"
      return [d, next_node]
    end
  end

  def get_possibles(node)
    row, col = node.first, node.last
    potentials = { "down_left" => [row - 1, col - 1], "down_right" => [row - 1, col + 1],
                   "up_left" => [row + 1, col - 1], "up_right" => [row + 1, col + 1],
                   'right' => [row, col + 1], 'left' => [row, col - 1],
                   'up' => [row + 1, col], 'down' => [row - 1, col] }
    adjacent = potentials.reject { |d, n| check_bounds(n) }
    possible = adjacent.reject { |d, n| check_shape(node, n) }
  end

  def get_linear(dir, node)
    get_possibles(node).reject { |d, n| dir == d ? false : true }
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
    row = @board_obj.check_column(move)
    row = row == false ? 7 : -(@board_obj.check_column(move))
    col = move - 1
    row == 1 ? row = 0 : row -= 2
    [row, col]
  end
end