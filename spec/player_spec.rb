# frozen_string_literal: true

require './lib/player'
require './lib/game'

describe Player do
  describe '#make_move' do
    subject(:player_move) { described_class.new(Game.new) }
    
    it 'returns a number between 1 and 7' do
      move = player_move.make_move
      expect(move).to be_between(1, 7)
    end
    
    it 'calls Game#check_move' do
      game = player_move.instance_variable_get(:@game)
      allow(game.board).to receive(:check_move).and_return(true)
      player_move.make_move
      expect(game.board).to have_received(:check_move)
    end
  end
end
