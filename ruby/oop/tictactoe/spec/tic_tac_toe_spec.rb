require 'spec_helper'
require 'tic_tac_toe'

describe 'TicTacToe' do
  let(:game) { TicTacToe.new }

  context 'game over' do

    context 'winning combo' do
      after :each do
        @spaces.each { |space| game.place_mark(:X, space) }
        expect(game).to receive(:game_over)
        expect(game).to receive(:select_space)
        expect(game).to receive(:show_board)
        expect(game.board_full?).to be false
        game.start
      end

      it 'ends game with 3 across' do
        @spaces = [:A1, :A2, :A3]
      end

      it 'ends game with 3 down' do
        @spaces = [:A1, :B1, :C1]
      end

      it 'ends game with 3 diagonal' do
        @spaces = [:A1, :B2, :C3]
      end

    end

    context "cat's game" do

      it 'ends game when board is full' do
        expect(game).to receive(:game_over)
        TicTacToe::SPACES.each do |space|
          mark = [:X, :O].sample
          game.place_mark(mark, space)
        end
        game.start
      end

    end

  end

  context "player interaction" do

    context "selecting a space" do

      context "invalid entry" do
        it "rejects invalid spaces" do
          space = " "
          expect { game.parse(space) }.to raise_error(ArgumentError)
        end

        it "rejects already filled spaces" do
          game.place_mark(:X, :A1)
          space = "A1"
          expect { game.parse(space) }.to raise_error(ArgumentError)
        end
      end

      context "valid entry" do
        after :each do
          expect(game.parse(@space)).to eql(:A1)
        end

        it "accepts valid spaces" do
          @space = "A1"
        end

        it "accepts number first" do
          @space = "1A"
        end

        it "is case-insensitive" do
          @space = "a1"
        end
      end

    end

  end

end