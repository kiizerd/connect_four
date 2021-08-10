class Connector

  attr_reader :board

  def initialize(gameboard)
    @board = gameboard
    @graph = gameboard.board.reverse
    @found = false
  end

  def found
    start_path

    @found
  end

  def start_path
    root = @board.last_node

    @queue = get_possibles(root)
    path_from_node(root)
  end
  
  def path_from_node(root)
    possibles = @queue.clone
    until possibles.empty?
      dir       = possibles.keys[0]
      opp       = opposites[dir]
      tail_node = get_tail_node(dir, root)
      
      if get_path_length(opp, tail_node) == 4
        @found = true
        @path  = get_path(opp, tail_node)
      end

      possibles.shift
    end
  end

  def get_tail_node(dir, node)
    tail = node
    until next_node(dir, tail).nil?
      tail = next_node(dir, tail)
    end

    return tail
  end

  def get_path_length(dir, node)
    get_path(dir, node).size
  end

  def get_path(dir, node)
    path    = [node]
    current = node
    while next_node(dir, current) && path.size < 4
      current = next_node(dir, current)
      path << current      
    end

    return path
  end

  def opposites
    { "down_left" => "up_right", "down_right" => "up_left",
      "up_left" => "down_right", "up_right" => "down_left",
      "right" => "left", "left" => "right",
      "up" => "down", "down" => "up" }
  end

  def next_node(dir, node)
    get_linear(dir, node)[dir]
  end

  def get_possibles(node)
    row, col = node.first, node.last
    potentials = { "down_left" => [row - 1, col - 1], "down_right" => [row - 1, col + 1],
                   "up_left" => [row + 1, col - 1], "up_right" => [row + 1, col + 1],
                   'right' => [row, col + 1], 'left' => [row, col - 1],
                   'up' => [row + 1, col], 'down' => [row - 1, col] }
    adjacent = potentials.select { |d, n| check_bounds(n) }
    possible = adjacent.select   { |d, n| check_shape(node, n) }
  end

  def get_linear(dir, node)
    get_possibles(node).select { |d, n| dir == d ? true : false }
  end

  def check_bounds(node)
    row, col = node.first, node.last
    return false if row > 5 || row < 0
    return false if col > 6 || col < 0
    return true
  end

  def check_shape(node, current)
    @shape = @graph[node[0]][node[1]]
    return true if @graph[current[0]][current[1]] == @shape
    return false
  end
end