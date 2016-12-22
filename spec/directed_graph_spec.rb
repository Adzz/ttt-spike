require 'spec_helper'
require 'directed_graph'
require 'node'
require 'pry'

RSpec.describe DirectedGraph do
 
  it 'suggests a winning move when there is a winning move to make.' do
    dg = described_class.new(Node.new("X", ["O",1,"X","X",4,5,"X","O","O"]))
    expect(dg.choose_move).to eq ["O",1,"X","X","X",5,"X","O","O"]
  end

  it "will chose a winning move over blocking an opponent's winning move" do
    dg = described_class.new(Node.new("X", ["O","O",2,"X",4,"X",6,7,8]))
    expect(dg.choose_move).to eq ["O","O",2,"X","X","X",6,7,8]
  end

  it "will chose a winning move over blocking an opponent's winning move" do
    dg = described_class.new(Node.new("X", [0,1,2,3,4,5,6,7,8]))
    expect(dg.choose_move).to eq ["X",1,2,3,4,5,6,7,8]
  end
end

