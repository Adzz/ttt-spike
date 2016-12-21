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
end
