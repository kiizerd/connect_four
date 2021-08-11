require '../lib/connector'
require '../lib/board'

describe Connector do
  let(:player)        { double 'player' }
  let(:player2)       { double 'player' }
  let(:board)         { GameBoard.new }
  subject(:connector) { Connector.new board }

  before { allow(player).to  receive(:shape) { "O" } }
  before { allow(player2).to receive(:shape) { "X" } }
  
  describe '#found?' do
    context 'path of 4 found from last move' do  
      it 'returns true' do
        4.times { |i| board.apply_move i, player }
        found = connector.found?
        expect(found).to be true
      end
    end
    
    context 'path of 4 not found' do
      it 'returns false' do
        board.apply_move 1, player
        found = connector.found?
        expect(found).to be false
      end
    end
  end

  describe '#get_tail_node' do
    context 'valid path of 4 on bottom row' do
      before { 5.times { |i| board.apply_move i, player } }
      let(:node) { connector.get_tail_node 'left', [0, 0] }

      it 'returns an array' do
        expect(node).to be_an Array
      end

      it 'returns a node from the bottom row' do
        expect(node[0]).to be 0
      end
    end

    context 'given empty node' do
      let(:node) { connector.get_tail_node 'up', [0, 0] }

      it 'returns false' do
        expect(node).to be false
      end
    end
  end

  describe '#get_path' do
    context 'valid path of 4' do
      before { 4.times { |i| board.apply_move i, player } }
      let(:path) { connector.get_path 'right', [0, 0] }

      it 'returns an array' do
        expect(path).to be_an Array
      end

      it 'returned array has size of 4' do
        expect(path.size).to eq 4
      end
    end

    context 'no valid path' do
      before { board.apply_move 1, player }
      let(:path) { connector.get_path 'up', [0, 0] }

      it 'returns an array' do
        expect(path).to be_an Array
      end

      it 'returned array contains only root node' do
        expect(path.first).to eq [0, 0]
      end
    end
  end

  describe '#get_next_node' do
    before { 2.times { board.apply_move 0, player } }
    let(:node) { [0, 0] }

    context 'valid node exists in given direction' do
      let(:dir) { 'up' }
      let(:next_node) { connector.get_next_node 'up', node }

      it 'returns an array' do
        expect(next_node).to be_an Array
      end

      it 'returns the correct node' do
        expect(next_node).to eq [1, 0]
      end
    end

    context 'no valid node in given direction' do
      let(:next_node) { connector.get_next_node 'right', node }

      it 'returns false' do
        expect(next_node).to be false
      end
    end
  end

  describe '#get_possibles' do
    context 'given node with 3 possible paths' do
      before { 2.times { 2.times { |i| board.apply_move i, player } } }
      let(:node) { [0, 0] }
      let(:possibles) { connector.get_possibles node }

      it 'returns an hash' do
        expect(possibles).to be_a Hash
      end

      it 'returns a hash with size of 3' do
        expect(possibles.size).to be 3
      end

      it 'returns a hash with correct paths' do
        expect(possibles).to eq({
          'up'       => [1, 0],
          'right'    => [0, 1],
          'up_right' => [1, 1]
        })
      end
    end

    context 'given node with 0 possible paths' do
      it 'returns an empty hash' do
        possibles = connector.get_possibles [0, 0]
        expect(possibles).to eq Hash.new
      end
    end
  end

  describe '#check_bounds' do
    context 'given node inside board' do
      it 'returns true' do
        check = connector.check_bounds 1, 1
        expect(check).to be true
      end
    end

    context 'given node outside board' do
      it 'returns false' do
        check = connector.check_bounds 7, 7
        expect(check).to be false
      end
    end
  end

  describe '#check_shape' do
    context 'given 2 nodes with matching shapes' do
      before { 2.times { board.apply_move 0, player } }

      it 'returns true' do
        check = connector.check_shape *[0, 0], *[1, 0]
        expect(check).to be true
      end
    end

    context 'given 2 node with non-matching shapes' do
      before { board.apply_move 0, player  }
      before { board.apply_move 0, player2 }

      it 'returns false' do
        check = connector.check_shape *[0, 0], *[1, 0]
        expect(check).to be false
      end
    end

    context 'given a node with no shape' do
      it 'returns false' do
        check = connector.check_shape *[0, 0], *[1, 1]
        expect(check).to be false
      end
    end
  end

end