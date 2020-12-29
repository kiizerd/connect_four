require './lib/game'

describe Game do
  describe "#player_input" do

    subject(:game_input) { described_class.new }
    
    it "should attempt to verify input" do
      input = '3'
      allow(subject).to receive(:gets).and_return(input)
      allow(subject).to receive(:verify_input).and_return(true)
      expect(subject).to receive(:verify_input).with(Integer, Integer, Integer)
      game_input.player_input(0, 4)
    end

    it "it handles different ranges" do
      allow(subject).to receive(:verify_input).and_return(true)
      expect {
        game_input.player_input(0, 2)
        game_input.player_input(1, 7)
      }.not_to raise_error
    end

    it "loops until input within range" do
      invalid = '7'
      valid = '3'
      allow(subject).to receive(:gets).and_return(invalid, invalid, valid)
      expect(subject).to receive(:gets).exactly(3).times
      game_input.player_input(1, 4)
    end
    
    it "should return input as Integer" do
      input = '3'
      allow(subject).to receive(:gets).and_return(input)
      test = game_input.player_input(1, 5)
      expect(test).to eq(input.to_i)
    end
  end

  describe "#verify_input" do
    
    subject(:game_verify) { described_class.new }
    
    context "given bad input" do
      it "should return false" do
        input = 6
        test = game_verify.verify_input(input, 0, 4)
        expect(test).to be(false)
      end
    end

    context "given good input" do
      it "should return given input" do
        input = 2
        test = game_verify.verify_input(input, 0, 2)
        expect(test).to eq(input.to_i)
      end
    end

  end

  describe "#get_moves" do
    
    subject(:game_moves) { described_class.new }
    let(:moves) { game_moves.get_moves }

    xit "should return an array" do
      expect(moves).to be_an(Array)
    end

    xit "should call Player#make_move on players array" do
      
    end

    xit "should call check_move" do
      
    end
  end

  describe "#make_board" do

    subject(:game_board) { described_class.new }
    let(:board) { game_board.make_board }

    context "on game start" do
      it "should return an Array" do
        expect(board).to be_an(Array)
      end
      
      it "should return 2d-array full of space chars" do
        expect(board[0]).to all( eq(' ') )
      end

      it "should return a 7x7 grid" do
        check_array = board.all? { |elem| elem.is_a? Array }
        check_length = board.all? { |ary| ary.length == 7 }
        mega_check = check_array && check_length
        expect(mega_check).to be(true)
      end
    end
  end

  describe "#get_players" do
    
    subject(:game_players) { described_class.new }
    let(:players) { game_players.get_players }
    let(:comp_players) { game_players.get_players(0) }

    before do
      allow(subject).to receive(:player_input).and_return(2)
    end

    it "should return array of Player objects" do
      expect(players).to all( be_a(Player) )
    end

    context "2 human players" do
      it "should return array of all Human players" do
        expect(players).to all( be_a(Human) )        
      end
    end

    context "2 Comp players" do
      it "should return array of all Comp players" do
        expect(comp_players).to all( be_a(Comp) )
      end
    end
  end

  describe "#win_game?" do

  end

  describe "#game_over" do

  end
end
