require_relative 'player'
require_relative 'display'

class Game

  def initialize
    @players = get_players
  end
  def make_board
    board = []
    7.times do |row|
      row = []
      7.times { row << [nil] }
      board << row
    end
    board
  end

  def get_players
    @players = [Player.new]*2
  end

  def get_moves
    moves = []
    moves << @players.first.make_move
    moves << @players.last.make_move
    moves
  end

end
