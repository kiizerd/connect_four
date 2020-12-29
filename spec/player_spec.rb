require './lib/player'

describe Player do
  describe "#make_move" do

    let(:game) { instance_double("Game") }
    subject(:player_move) { described_class.new(game) }
    before do
      allow(game).to receive(:check_move).and_return(true)
    end
    
    it "should return a number between 1 and 7" do
      move = player_move.make_move
      expect(move).to be_between(1, 7)
    end

    it "should call Game#check_move" do
      expect(game).to receive(:check_move)
      player_move.make_move
    end
  end
end

describe Human do
  
end

describe Comp do
  
end