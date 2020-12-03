require './lib/game'

describe Game do
  game = Game.new
  describe "#make_board" do
    board = game.make_board
    it "returns an array representing the board" do
      expect(game.make_board).to be_instance_of(Array)
    end
    it "board is 7 rows" do
      expect(board.length).to eql(7)
    end

    it "each row has 7 columns" do      
      expect(board.first.length).to eql(7)
    end
  end

  describe "#get_moves" do
    it "returns an array" do
      expect(game.get_moves).to be_an(Array)
    end

    it "each element is correct format" do
      moves = game.get_moves
      first = moves.first
      second = moves.last
      length = first.length == 3 && second.length == 3
      is_string = first.class == String && second.class == String
      middle_min = first.split('')[1] == '-'
      megacheck = length && is_string && middle_min
      expect(megacheck).to be(true)
    end
  end

  describe "#get_players" do
    it "returns an array" do
      expect(game.get_players).to be_instance_of(Array)
    end

    it "each element is Player class" do
      players = game.get_players
      expect(players).to all( be_a(Player))
    end
  end
end
