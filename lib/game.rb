# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'display'
require_relative 'connector'

class Game

  include Display

  def initialize
    @board     = GameBoard.new
    @connector = Connector.new(@board)
  end

  def main_menu
    welcome_screen
    option = user_input(1, 3)
    case option
    when 1 then player_selection
    when 2 then more_info
    when 3 then exit(0)  
    end
  end
  
  def start
    p1, p2  = @players
    current = p1
    42.times do |i|
      try_move(current)
      break if @connector.found?
      current = current == p1 ? p2 : p1
    end
    game_over
  end

  def restart
    @board     = GameBoard.new
    @connector = Connector.new(@board)
    player_selection
  end

  def player_selection
    puts `clear`, player_selection_prompt
    human_players = user_input(0, 2)
    case human_players
    when 0 then @players = [Comp.new('O'), Comp.new('X')]      
    when 1 then @players = [Human.new('X'), Comp.new('O')]
    when 2 then @players = [Human.new('O'), Human.new('X')]
    end

    start
  end

  def try_move player
    show_board(@board.board)
    col = player.is_a?(Human) ? user_input(1, 7) - 1 : player.move
    if @board.check_column col
      @board.apply_move(col, player.shape)
      return true
    end
    return false
  end
  
  def user_input(min, max)
    human_move_prompt(min, max)
    loop do
      input = gets.chomp.to_i
      return input if verify_input(min, max, input)
    end
  end

  def verify_input(min, max, input)
    input >= min && input <= max ? input : false
  end
  
  def game_over
    winner = check_for_winner
    show_board(@board.board)
    show_game_over(winner ? winner : 'No one')
    option = user_input(1, 2)
    case option
    when 1 then restart
    when 2 then exit(0)
    end
  end

  def check_for_winner
    return false if @connector.path.size < 4
    root  = @connector.path[0]
    shape = @board.board[-(root[0] + 1)][root[1]]

    return @players.select { |p| p.shape == shape }[0]
  end
end
