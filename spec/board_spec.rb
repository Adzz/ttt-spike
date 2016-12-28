require 'spec_helper'
require 'board.rb'

RSpec.describe Board do
  describe '#update_state' do
    it 'updates the state of a board for the given position and player' do
      expect(subject.update_state(4, 'X')).to eq [0,1,2,3,'X',5,6,7,8]
    end
  end

  describe '#renderable_board' do
    let(:renderable_board) do
      [
        "           |     |          ",
        "           |     |          ",
        "      _____|_____|_____     ",
        "           |     |          ",
        "           |     |          ",
        "      _____|_____|_____     ",
        "           |     |          ",
        "           |     |          ",
        "           |     |          "
      ]
    end

    it 'generates a string representation of the board state' do
      expect(subject.renderable_board).to eq renderable_board
    end

    context 'updated state' do
      it 'when the state is updated renderable_board gives us a representation of the new state' do
        renderable_board[1][8] = 'X'
        subject.update_state(0, 'X')
        expect(subject.renderable_board).to eq renderable_board
      end
    end
  end
end
