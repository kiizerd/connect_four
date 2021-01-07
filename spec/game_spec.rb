# frozen_string_literal: true
require 'stringio'
require './lib/game'

describe Game do
  describe '#player_input' do
    subject(:game_input) { described_class.new }
      
    it 'loops until input within range' do
      players = game_input.get_players 1
      allow(game_input).to receive(:gets).and_return("9\n","6\n")
      expect(game_input).to receive(:gets).twice
      game_input.player_input(1, 7)
    end

    it 'returns input as integer' do
      allow(game_input).to receive(:gets).and_return("2\n")
      input = game_input.player_input(1, 4)
      expect(input).to eq(2)
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
    
    it 'returns an array' do
      moves = game_moves.players_moves
      expect(moves).to be_an(Array)
    end

    it 'calls Player#make_move on each players array' do
      players = game_moves.instance_variable_get(:@players)
      players.each do |p|
        allow(p).to receive(:make_move).and_return(rand(6) + 1)
      end
      game_moves.players_moves
      expect(players).to all(have_received(:make_move))
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
end
