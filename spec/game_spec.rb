# frozen_string_literal: true
require 'stringio'
require './lib/game'

describe Game do
  describe '#player_input' do
    subject(:game_input) { described_class.new }
    let(:good_input) { StringIO.new('1\n') }
    let(:bad_then_good) { StringIO.new('14\n9\n2\n') }

    it 'handles different ranges' do
      expect do
        game_input.player_input(0, 2)
        game_input.player_input(1, 7)
      end.not_to raise_error
    end

    it 'loops until input within range' do
      $stdin = bad_then_good
      game_input.player_input(1, 4)
      expect(game_input).to receive(:gets).exactly(3).times
      $stdin = STDIN
    end

    it 'returns input as Integer' do
      input = '3'
      test = game_input.player_input(1, 5)
      expect(test).to eq(input.to_i)
    end
  end

  describe '#verify_input' do
    subject(:game_verify) { described_class.new }

    context 'when given bad input' do
      it 'returns false' do
        input = 6
        test = game_verify.verify_input(input, 0, 4)
        expect(test).to be(false)
      end
    end

    context 'when given good input' do
      it 'returns given input' do
        input = 2
        test = game_verify.verify_input(input, 0, 2)
        expect(test).to eq(input.to_i)
      end
    end
  end

  describe '#players_moves' do
    subject(:game_moves) { described_class.new }

    let(:moves) { game_moves.get_moves }

    it 'returns an array' do
      expect(moves).to be_an(Array)
    end

    it 'calls Player#make_move on players array' do
      players = game_moves.get_players
      players.each { |player| allow(player).to receive(:make_move).and_return(rand(7)) }
      expect(players).to all(have_received(:make_move))
      game_moves.get_moves
    end
  end

  describe '#get_players' do
    subject(:game_players) { described_class.new }

    let(:players) { game_players.get_players }
    let(:comp_players) { game_players.get_players(0) }

    it 'returns array of Player objects' do
      expect(players).to all(be_a(Player))
    end

    context 'with 2 human players' do
      it 'returns array of all Human players' do
        players = game_players.get_players 2
        expect(players).to all(be_a(Human))
      end
    end

    context 'with 2 Comp players' do
      it 'returns array of all Comp players' do
        expect(comp_players).to all(be_a(Comp))
      end
    end
  end

  describe '#look_for_4' do
    subject(:game_look) { described_class.new }

    let(:board) { game_look.make_board }

    context 'when 4 in a row found' do
      before do
        4.times { |i| board[-1][i] = 'O' }
      end

      xit 'returns winner' do
        winner = game_look.look_for_4
        expect(winner.piece).to eq('O')
      end
    end

    context 'when 4 not found' do
      xit 'should return false' do
        winner = game_look.look_for_4
        expect(winner).to be(false)
      end
    end
  end

  describe '#game_over' do
    # gasdg
  end
end
