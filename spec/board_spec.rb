# frozen_string_literal: true

require './lib/board'
require './lib/player'

describe GameBoard do
  describe '#check_column' do
    subject(:board_column) { described_class.new }

    let(:board) { board_column.board }

    context 'column is full' do
      before do
        6.times { |i| board[i - 1][0] = 'O' }
      end

      it 'returns false' do
        check = board_column.check_column(1)
        expect(check).to be(false)
      end
    end

    context '2nd row is empty' do
      before do
        board[-1][0] = 'O'
      end

      it 'returns -2' do
        check = board_column.check_column(1)
        expect(check).to eq(-2)
      end
    end

    context 'top row is empty' do
      before do
        player = double(Player, shape: 'O')
        5.times { board_column.apply_move(1, player) }
      end

      it 'returns -6' do
        check = board_column.check_column(1)
        expect(check).to eq(-6)
      end
    end
  end

  describe '#apply_move' do
    subject(:board_apply) { described_class.new }
    let(:board) { board_apply.board }
    
    it 'applies move to gameboard' do
      player = double(Player, shape: 'O')
      players = [player, player]
      board_apply.apply_move(1, players.sample)
      expect(board[-1][0]).not_to eq(' ')
    end
  end
end
