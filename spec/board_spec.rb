# frozen_string_literal: true

require './lib/board'
require './lib/player'

describe GameBoard do
  subject(:board) { described_class.new }
  let(:graph)     { board.board }
  let(:player)    { double('player', shape: 'O') }

  before { allow(player).to receive(:move).and_return 1 }

  describe '#check_column' do
    context 'column is full' do
      before do
        6.times { |i| graph[i - 1][1] = 'O' }
      end

      it 'returns false' do
        check = board.check_column(1)
        expect(check).to be false
      end
    end

    context 'column is not full' do
      it 'returns true' do
        check = board.check_column 1
        expect(check).to be true
      end
    end
  end

  describe '#apply_move' do
    it 'applies move to gameboard' do
      board.apply_move player
      expect(graph[-1][1]).to eq('O')
    end
  end
end
