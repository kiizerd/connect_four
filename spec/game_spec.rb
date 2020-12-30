# frozen_string_literal: true

require './lib/game'

describe Game do
  describe '#player_input' do
    subject(:game_input) { described_class.new }

    it 'attempts to verify input' do
      input = '3'
      allow(subject).to receive(:gets).and_return(input)
      allow(subject).to receive(:verify_input).and_return(true)
      expect(subject).to receive(:verify_input).with(Integer, Integer, Integer)
      game_input.player_input(0, 4)
    end

    it 'handles different ranges' do
      allow(subject).to receive(:verify_input).and_return(true)
      expect do
        game_input.player_input(0, 2)
        game_input.player_input(1, 7)
      end.not_to raise_error
    end

    it 'loops until input within range' do
      invalid = '7'
      valid = '3'
      allow(subject).to receive(:gets).and_return(invalid, invalid, valid)
      expect(subject).to receive(:gets).exactly(3).times
      game_input.player_input(1, 4)
    end

    it 'returns input as Integer' do
      input = '3'
      allow(subject).to receive(:gets).and_return(input)
      test = game_input.player_input(1, 5)
      expect(test).to eq(input.to_i)
    end
  end

  describe '#verify_input' do
    subject(:game_verify) { described_class.new }

    context 'given bad input' do
      it 'returns false' do
        input = 6
        test = game_verify.verify_input(input, 0, 4)
        expect(test).to be(false)
      end
    end

    context 'given good input' do
      it 'returns given input' do
        input = 2
        test = game_verify.verify_input(input, 0, 2)
        expect(test).to eq(input.to_i)
      end
    end
  end

  describe '#get_moves' do
    subject(:game_moves) { described_class.new }

    let(:moves) { game_moves.get_moves }

    it 'returns an array' do
      expect(moves).to be_an(Array)
    end

    it 'calls Player#make_move on players array' do
      players = game_moves.get_players
      players.each do |player|
        allow(player).to receive(:make_move).and_return(rand(7))
      end
      expect(players).to all(receive(:make_move))
      game_moves.get_moves
    end
  end

  describe '#get_players' do
    subject(:game_players) { described_class.new }

    let(:players) { game_players.get_players }
    let(:comp_players) { game_players.get_players(0) }

    before do
      allow(subject).to receive(:player_input).and_return(2)
    end

    it 'returns array of Player objects' do
      expect(players).to all(be_a(Player))
    end

    context '2 human players' do
      it 'returns array of all Human players' do
        expect(players).to all(be_a(Human))
      end
    end

    context '2 Comp players' do
      it 'returns array of all Comp players' do
        expect(comp_players).to all(be_a(Comp))
      end
    end
  end

  describe '#look_for_4' do
    subject(:game_look) { described_class.new }

    let(:board) { game_look.make_board }

    context '4 in a row found' do
      before do
        4.times { |i| board[-1][i] = 'O' }
      end

      xit 'should return winner' do
        winner = game_look.look_for_4
        expect(winner.piece).to eq('O')
      end
    end

    context '4 not found' do
      xit 'should return false' do
        winner = game_look.look_for_4
        expect(winner).to be(false)
      end
    end
  end

  describe '#game_over' do
  end
end
