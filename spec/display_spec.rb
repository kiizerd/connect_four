require './lib/display'

describe Display do
  display = Display.new
  describe "#make_board" do
    board = display.make_board
    it "returns an array" do
      expect(board).to be_an(Array)
    end

    it "array length of 15" do
      expect(board.length).to be(15)
    end

    it "first and last should be identical" do
      same = board[0] == board[-1]
      expect(same).to be(true)
    end
    
    it "every even element is the same" do
      same = board[1] == board[-2]
      expect(same).to be(true)
    end

    it "every other odd element should be identical" do
      same = board[2] == board[-3]
      expect(same).to be(true)
    end
  end
  
  describe "#update" do
    it "replaces given position with players gamepiece" do
      new_board = display.update('1-1')
      first_row = new_board[1].gsub(/\s+/, '')
      piece = "\u25CF".encode
      blue = "\e[34m#{piece}\e[0m"
      expect(first_row.split('')[1]).to eql(piece)
    end

    it "returns new board as array" do
      expect(display.update('1-2')).to be_an(Array)
    end
    
    it "returns false if given bad move" do
      expect(display.update('8-1')).to eql(false) 
    end

    it "returns false if given move taken" do
      display.update('1-1')
      expect(display.update('1-1')).to eql(false)
    end
  end

  describe "#good_move?" do
    it "returns false if given move is taken" do
      display.update('1-1')
      expect(display.good_move?('1-1')).to eql(false)
    end

    it "returns false if given move is outside bounds" do
      expect(display.good_move?('8-1')).to eql(false)
    end

    it "returns true if not taken" do
      expect(display.good_move?('3-4')).to eql(true)
    end
  end

  describe "#check" do
    it "returns piece at given position" do
      display.update('1-1')
      piece = "\u25CF".encode
      expect(display.check('1-1')).to eql(piece)
    end

    it "returns '#' if no piece in position" do
      expect(display.check('7-7')).to eql('#')
    end
  end
end
