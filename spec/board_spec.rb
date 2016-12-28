require 'spec_helper'
require 'board.rb'

RSpec.describe Board do
  describe '#update_state' do
    it 'updates the state of a board for the given position and player' do
      expect(subject.update_state(4, 'X')).to eq [0,1,2,3,'X',5,6,7,8]
      expect(subject.state).to eq [0,1,2,3,'X',5,6,7,8]
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

  describe '#height' do
    it 'returns the visual hieght of the board' do
      expect(subject.height).to eq 9
    end
  end

  describe '#width' do
    it 'returns the visual width of the board' do
      expect(subject.width).to eq 28
    end
  end

  describe '#state' do
    it 'returns the state of the board' do
      expect(subject.state).to eq [*0..8]
    end
  end
end
