class Connector

  attr_reader :board

  def initialize(gameboard)
    @board = gameboard
    @graph = gameboard.board.reverse
    @path_found = false
  end

  def found?
    root   = @board.last_node
    @queue = get_possibles(root)
    path_from_node(root)

    @path_found
  end

  def path_from_node(root)
    possibles = @queue.clone
    until possibles.empty?
      dir       = possibles.keys[0]
      opp       = opposites[dir]
      tail_node = get_tail_node(dir, root)
      
      if get_path_length(opp, tail_node) == 4
        @path = get_path(opp, tail_node)
        @path_found = true
      end

      possibles.shift
    end
  end

  def get_tail_node(dir, node)
    return false if @graph[node[0]][node[1]] == ' '
    tail = node
    tail = get_next_node(dir, tail) while get_next_node(dir, tail)
    return tail
  end

  def get_path_length(dir, node)
    get_path(dir, node).size
  end

  def get_path(dir, node)
    path    = [node]
    current = node
    while get_next_node(dir, current) && path.size < 4
      current = get_next_node(dir, current)
      path << current      
    end

    return path
  end

  def get_next_node(dir, root)
    node = get_possibles(root).select { |d, n| true if dir == d }[dir]
    return node.nil? ? false : node
  end

  def get_possibles(node)
    potentials(*node)
      .select { |d, n| check_bounds(*n) }
      .select { |d, n| check_shape(*node, *n) }
  end

  def check_bounds(row, col)
    return false if row > 5 || row < 0
    return false if col > 6 || col < 0
    return true
  end

  # Takes 2 coordinate pairs and compares the node values
  def check_shape(r_row, r_col, n_row, n_col)
    @shape = @graph[r_row][r_col]
    return false if @shape == ' ' || @graph[n_row][n_col] != @shape
    return true
  end

  def potentials(row, col)
    {
      'up'         => [row + 1, col],
      'down'       => [row - 1, col],
      'left'       => [row, col - 1],
      'right'      => [row, col + 1],
      "up_left"    => [row + 1, col - 1],
      "up_right"   => [row + 1, col + 1],
      "down_left"  => [row - 1, col - 1],
      "down_right" => [row - 1, col + 1]
    }
  end

  def opposites
    {
      "up"         => "down",
      "down"       => "up",
      "left"       => "right",
      "right"      => "left",
      "up_left"    => "down_right",
      "up_right"   => "down_left",
      "down_left"  => "up_right",
      "down_right" => "up_left"
    }
  end
end