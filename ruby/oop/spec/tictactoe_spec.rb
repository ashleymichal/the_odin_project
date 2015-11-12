require 'spec_helper'
require 'tictactoe'

describe TicTacToe do

	describe Player do

		describe '#new' do

			describe 'attributes' do

				it 'returns :X for player 1' do
					expect(subject.mark).to eq(:X)
				end

				it 'returns :O for player 2' do
					expect(subject.mark).to eq(:O)
				end

			end
		end
	end

	describe Board do

		context 'a new game board' do

			it 'shows three rows of three blank spaces' do
				expect{ subject.show }.to output("    1   2   3\nA  |   |   |   |\nB  |   |   |   |\nC  |   |   |   |\n").to_stdout
			end

		end

	end

end


# user story (2 users)
# game begins and user is presented with a board.