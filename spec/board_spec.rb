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

  describe "#winning_board_for?" do
    context 'when player is X' do
      let(:player) { "X" }

      it 'returns true if X take the top row' do
        board = Board.new(["X","X","X",3,4,5,6,7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes the middle row' do
        board = Board.new([0,1,2,"X","X","X",6,7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes the bottom row' do
        board = Board.new([0,1,2,3,4,5,"X","X","X"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X take the left column' do
        board = Board.new(["X",1,2,"X",4,5,"X",7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes the middle column' do
        board = Board.new([0,"X",2,3,"X",5,6,"X",8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes the right column' do
        board = Board.new([0,1,"X",3,4,"X",6,7,"X"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns false if X or O do not take a winning row' do
        expect(subject.winning_board_for?(player)).to be false

        board = Board.new(["X", "O",2,3,4,5,"X","O",8])
        expect(board.winning_board_for?(player)).to be false
      end
    end

    context 'when player is O' do
      let(:player) { "O" }
      
      it 'returns true if O take the top row' do
        board = Board.new(["O","O","O",3,4,5,6,7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes the middle row' do
        board = Board.new([0,1,2,"O","O","O",6,7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes the bottom row' do
        board = Board.new([0,1,2,3,4,5,"O","O","O"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O take the left column' do
        board = Board.new(["O",1,2,"O",4,5,"O",7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes the middle column' do
        board = Board.new([0,"O",2,3,"O",5,6,"O",8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes the right column' do
        board = Board.new([0,1,"O",3,4,"O",6,7,"O"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns false if X or O do not take a winning row' do
        expect(subject.winning_board_for?(player)).to be false

        board = Board.new(["X", "O",2,3,4,5,"X","O",8])
        expect(board.winning_board_for?(player)).to be false
      end
    end
  end
end
