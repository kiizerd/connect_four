require '../lib/connector'
require '../lib/board'

describe Connector do

  board = instance_double(GameBoard)
  subject(:connector) { described_class.new(board) }

  describe '#find_4' do
    it 'returns false if not found' do
      connecter.find_4(1).to be(false)
    end
  end
end