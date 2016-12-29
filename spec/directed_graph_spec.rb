require 'spec_helper'
require 'directed_graph'
require 'node'
require 'pry'

RSpec.describe DirectedGraph do
  context 'when computer is X' do
    it 'suggests a winning move when there is a winning move to make.' do
      dg = described_class.new(Node.new("X", ["O",1,"X","X",4,5,"X","O","O"]))
      expect(dg.choose_move).to eq ["O",1,"X","X","X",5,"X","O","O"]
    end

    it "will block an opponent's winning move" do
      dg = described_class.new(Node.new("X", ["O","O",2,3,"X",5,6,"X",8]))
      expect(dg.choose_move).to eq ["O","O","X",3,"X",5,6,"X",8]
    end

    it "will chose a winning move over blocking an opponent's winning move" do
      dg = described_class.new(Node.new("X", ["O","O",2,"X","X",5,6,7,8]))
      expect(dg.choose_move).to eq ["O","O",2,"X","X","X",6,7,8]
    end

    it "will never select an edge as a first move for X" do
      dg = described_class.new(Node.new("X", [*0..8]))
      expect(dg.choose_move).to eq ["X",1,2,3,4,5,6,7,8]
    end
  end

  context 'When computer is O' do
    it "suggests the optimal first move for O's first move" do
      dg = described_class.new(Node.new("O", ["X",1,2,3,4,5,6,7,8]))
      expect(dg.choose_move).to eq ["X",1,2,3,"O",5,6,7,8]
    end

    it "will block an opponent's winning move" do
      dg = described_class.new(Node.new("O", ["X","O","X","O","O","X",6,"X",8]))
      expect(dg.choose_move).to eq ["X","O","X","O","O","X",6,"X","O"]
    end

    it "will chose a winning move over blocking an opponent's winning move" do
      dg = described_class.new(Node.new("O", ["X","X",2,"X",4,5,"O","O",8]))
      expect(dg.choose_move).to eq ["X","X",2,"X",4,5,"O","O","O"]
    end
  end
end

