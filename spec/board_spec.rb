# frozen_string_literal: true

require './lib/board'

describe GameBoard do
  describe '#check_move' do
    subject(:board_check) { described_class.new }

    let(:board) { board_check.board }

    context 'when move is taken' do
      before do
        7.times { |i| board[i - 1][0] = 'O' }
      end

      it 'calls check_column' do
        expect(board_check).to receive(:check_column).with(0)
        board_check.check_move(1)
      end

      it 'returns false' do
        check = board_check.check_move(1)
        expect(check).to be(false)
      end
    end

    context 'when move is good' do
      it 'returns move' do
        check = board_check.check_move(1)
        expect(check).to eq(1)
      end
    end
  end

  describe '#check_column' do
    subject(:board_column) { described_class.new }

    let(:board) { board_column.board }

    context 'column is full' do
      before do
        6.times { |i| board[i - 1][0] = 'O' }
      end

      it 'returns false' do
        check = board_column.check_column(0)
        expect(check).to be(false)
      end
    end

    context '2nd row is empty' do
      before do
        board[-1][0] = 'O'
      end

      it 'returns 2' do
        check = board_column.check_column(0)
        expect(check).to eq(2)
      end
    end

    context 'top row is empty' do
      before do
        5.times { |i| board[i - 1][0] = 'O' }
      end

      it 'returns 6' do
        check = board_column.check_column(0)
        expect(check).to eq(6)
      end
    end
  end

  describe '#make_board' do
    subject(:create_board) { described_class.new }

    let(:board) { create_board.board }

    context 'on game start' do
      it 'returns an Array' do
        expect(board).to be_an(Array)
      end

      it 'returns 2d-array full of space chars' do
        expect(board[0]).to all(eq(' '))
      end

      it 'returns a 6x7 grid' do
        check_array = board.all? { |elem| elem.is_a? Array }
        check_length = board.all? { |ary| ary.length == 7 }
        mega_check = check_array && check_length
        expect(mega_check).to be(true)
      end
    end
  end
end
