require 'spec_helper'
require 'node'
require 'pry'

RSpec.describe Node do
  context 'checking for an illegal board' do
    it 'player cant be O if there is no X on the board (X goes first)' do
      expect { Node.new("O", [1,2,3]) }.to raise_exception(ArgumentError)
    end

    it "player can't be X if it's O's turn" do
      expect { Node.new("X", ["X","O","X",3]) }.to raise_exception(ArgumentError)
    end

    it "player can't be O if it's X's turn" do
      expect { Node.new("O", ["X","O",2]) }.to raise_exception(ArgumentError)
    end
  end

  context 'successors' do
    context "when player is X" do
      it "will generate successors for each possible next move" do
        node = Node.new("X", [0,1])
        expect(node.successors.map(&:current_state)).to eq [["X",1],[0,"X"]]
      end

      context "will not generate successors with an X in an illegal place:" do
        it 'where an X was' do
          node = Node.new("X", [0,"X","O",3])
          expect(node.successors.map(&:current_state)).to eq [["X","X","O",3],[0,"X","O","X"]]
        end

        it 'where an O was' do
          node = Node.new("X", ["O","X",3])
          expect(node.successors.map(&:current_state)).to eq [["O","X","X"]]
        end
      end
    end

    context "when player is O" do
      it "will generate successors for each possible next move" do
        node = Node.new("O", ["X",1,2])
        expect(node.successors.map(&:current_state)).to eq [["X", "O", 2], ["X", 1, "O"]]
      end

      context "will not generate successors with an O in an illegal place:" do
        it 'where an X was' do
          node = Node.new("O", [0,"X"])
          expect(node.successors.map(&:current_state)).to eq [["O","X"]]
        end

        it 'where an O was' do
          node = Node.new("O", ["O","X","X",3])
          expect(node.successors.map(&:current_state)).to eq [["O","X","X","O"]]
        end
      end
    end
  end

  context 'winning_move_available' do
    it 'returns true when there is a winning move winning_move_available for the currrent player' do
      node = Node.new("X", ["X","X",2,3,"O","O",6,7,8])
      expect(node.can_win?).to be true
    end

    it 'returns false when there isnt' do
      node = Node.new("X", [*0..8])
      expect(node.can_win?).to be false
      node = Node.new("X", ["O","O",2,3,"X",5,6,"X",8])
      expect(node.can_win?).to be false
    end
  end

  context 'about_to_lose' do
    it 'returns true if there is a chance for the opponent to win'do
      node = Node.new("X", ["O","O",2,3,"X",5,6,"X",8])
      expect(node.about_to_lose?).to be true
    end
  end

  #  describe "#winning_board" do
  #   it 'returns true if X take the top row' do
  #     board = ["X","X","X",3,4,5,6,7,8]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if O take the top row' do
  #     board = ["O","O","O",3,4,5,6,7,8]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if X takes the middle row' do
  #     board = [0,1,2,"X","X","X",6,7,8]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if O takes the middle row' do
  #     board = [0,1,2,"O","O","O",6,7,8]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if X takes the bottom row' do
  #     board = [0,1,2,3,4,5,"X","X","X"]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if O takes the bottom row' do
  #     board = [0,1,2,3,4,5,"O","O","O"]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if X take the left column' do
  #     board = ["X",1,2,"X",4,5,"X",7,8]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if O take the left column' do
  #     board = ["O",1,2,"O",4,5,"O",7,8]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if X takes the middle column' do
  #     board = [0,"X",2,3,"X",5,6,"X",8]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if O takes the middle column' do
  #     board = [0,"O",2,3,"O",5,6,"O",8]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if X takes the right column' do
  #     board = [0,1,"X",3,4,"X",6,7,"X"]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns true if O takes the right column' do
  #     board = [0,1,"O",3,4,"O",6,7,"O"]
  #     expect(subject.winning_board?(board)).to be true
  #   end

  #   it 'returns false if X or O do not take a winning row' do
  #     board = [*0..8]
  #     expect(subject.winning_board?(board)).to be false

  #     board = ["X", "O",2,3,4,5,"X","O",8]
  #     expect(subject.winning_board?(board)).to be false
  #   end
  # end
end
