require 'ostruct'
require 'spec_helper'
require 'tic_tac_toe'

describe 'TicTacToe' do
  before :each do
    # start new game
    @game = TicTacToe.new
  end

  context 'game over' do

    context 'winning combo' do

      it 'ends game when winning combo is made' do
        [:A1, :A2, :A3].each { |space| @game.place_mark('X', space) }
        expect(@game).to receive(game_over)
      end

    end

    context 'cats game' do

      it 'ends game when board is full' do
        expect(@game).to receive(game_over)
        TicTacToe.space_names.each do |space|
          mark = ['X', 'O'].sample
          @game.place_mark(mark, space)
        end
      end

    end

  end

end