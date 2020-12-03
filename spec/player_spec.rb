require './lib/player'

describe Player do
  player = Player.new
  describe "#make_move" do
    it "returns a string" do
      move = player.make_move
      expect(move).to be_a(String)
    end

    it "rejects incorrect formatting" do
      output = <<~OUTPUT
        Enter your move
        Error, try again
      OUTPUT
      expect{ player.make_move }.to output(output).to_stdout
    end
  end

  describe "#check_move" do
    it "returns true for correct format" do
      expect(player.check_move('1-1')).to be(true)
    end

    it "returns false if outside range" do
      expect(player.check_move('8-1')).to be(false)
    end

    it "returns false if incorrect format" do
      expect(player.check_move('5 4')).to be(false)
    end

    it "returns false for letters" do
      expect(player.check_move('a-b')).to be(false)
    end
  end
end
