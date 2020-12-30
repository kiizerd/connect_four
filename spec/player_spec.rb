# frozen_string_literal: true

require './lib/player'

describe Player do
  describe '#make_move' do
    subject(:player_move) { described_class.new(game) }

    let(:game) { instance_double('Game') }

    before do
      allow(game).to receive(:check_move).and_return(true)
    end

    it 'returns a number between 1 and 7' do
      move = player_move.make_move
      expect(move).to be_between(1, 7)
    end

    it 'calls Game#check_move' do
      expect(game).to receive(:check_move)
      player_move.make_move
    end
  end
end

describe Human do
end

describe Comp do
end
