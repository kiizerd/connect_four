# frozen_string_literal: true
require 'stringio'
require './lib/game'

describe Game do
  subject(:game) { described_class.new }
  let(:player)   { double('player', shape: 'O') }
  let(:human)    { double('human', shape: 'X') }

  before do
    game.instance_variable_set(:@players, [human, player])
  end

  describe '#verify_input' do
    context 'given good input' do
      it 'returns input' do
        input = 3
        verified = game.verify_input(0, 5, input)
        expect(verified).to eq input
      end
    end
    
    context 'given bad input' do
      it 'returns false' do
        input = 7
        verified = game.verify_input(0, 5, input)
        expect(verified).to be false
      end
    end
  end

  describe '#try_move' do
    context 'given valid move' do
      it 'returns true' do
        allow(player).to receive(:move).and_return rand(1..6)
        attempt = game.try_move player
        expect(attempt).to be true
      end
    end
    
    context 'given invalid move' do
      it 'returns false' do
        allow(human).to receive(:move).and_return 8
        allow(human).to receive(:gets).and_return 14
        attempt = game.try_move human
        expect(attempt).to be false
      end
    end
  end

end
