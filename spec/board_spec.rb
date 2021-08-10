# frozen_string_literal: true

require './lib/board'
require './lib/player'

describe GameBoard do
  describe '#check_column' do
    subject(:board_column) { described_class.new }
    let(:board)            { board_column.board }

    context 'column is full' do
      before do
        6.times { |i| board[i - 1][1] = 'O' }
      end

      it 'returns false' do
        check = board_column.check_column(1)
        expect(check).to be false
      end
    end

    context 'column is not full' do
      it 'returns true' do
        check = board_column.check_column 1
        expect(check).to be true
      end
    end
  end

  describe '#apply_move' do
    subject(:board_apply) { described_class.new }
    let(:board)           { board_apply.board }
    
    it 'applies move to gameboard' do
      player = double(Player, shape: 'O')
      board_apply.apply_move(1, player)
      expect(board[-1][1]).to eq('O')
    end
  end
end
