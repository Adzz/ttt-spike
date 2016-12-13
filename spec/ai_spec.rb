require 'spec_helper'
require 'directed_graph.rb'
require 'node.rb'
require 'ai.rb'

RSpec.describe AI_X do
  context 'When X' do
    let(:node)      { Node.new("X", [*0..8]) }
    let(:game_tree) { DirectedGraph.new(node).game_tree }
    subject         { described_class.new(game_tree) }

    # xit 'selects top left when taking the first go' do
    #   game_state = [*0..8]
    #   expect(subject.next_move(game_state)).to eq ["X",1,2,3,4,5,6,7,8]
    # end

    it 'selects the winning move when there is one' do
      game_state = [
        [*0..8],
        ["X",1,2,3,4,5,6,7,8],
        ["X","O",2,3,4,5,6,7,8],
        ["X","O",2,"X",4,5,6,7,8],
        ["X","O",2,"X",4,5,6,7,"O"],
      ]

      expect(subject.next_move(game_state)).to eq ["X","O",2,"X",4,5,"X",7,"O"]
    end
  end
end
