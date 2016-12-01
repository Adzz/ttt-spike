require 'spec_helper'
require 'available_moves.rb'

RSpec.describe AvailableMoves do
  describe "#available_positions" do
    let(:board) { [*0..8] }

    it 'returns the reamaining free' do
      starting_position = board.sample
      expect(subject.available_positions(starting_position)).to eq board - [starting_position]
    end
  end

  describe "#winning_board" do
    it 'returns true if X take the top row' do
      board = ["X","X","X",3,4,5,6,7,8]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if O take the top row' do
      board = ["O","O","O",3,4,5,6,7,8]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if X takes the middle row' do
      board = [0,1,2,"X","X","X",6,7,8]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if O takes the middle row' do
      board = [0,1,2,"O","O","O",6,7,8]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if X takes the bottom row' do
      board = [0,1,2,3,4,5,"X","X","X"]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if O takes the bottom row' do
      board = [0,1,2,3,4,5,"O","O","O"]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if X take the left column' do
      board = ["X",1,2,"X",4,5,"X",7,8]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if O take the left column' do
      board = ["O",1,2,"O",4,5,"O",7,8]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if X takes the middle column' do
      board = [0,"X",2,3,"X",5,6,"X",8]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if O takes the middle column' do
      board = [0,"O",2,3,"O",5,6,"O",8]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if X takes the right column' do
      board = [0,1,"X",3,4,"X",6,7,"X"]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns true if O takes the right column' do
      board = [0,1,"O",3,4,"O",6,7,"O"]
      expect(subject.winning_board?(board)).to be true
    end

    it 'returns false if X or O do not take a winning row' do
      board = [*0..8]
      expect(subject.winning_board?(board)).to be false

      board = ["X", "O",2,3,4,5,"X","O",8]
      expect(subject.winning_board?(board)).to be false
    end
  end
end
