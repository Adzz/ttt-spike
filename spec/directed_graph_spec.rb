require 'spec_helper'
require 'directed_graph'
require 'node'

RSpec.describe DirectedGraph do
  context 'generating a game tree' do
    it 'produces a game tree of all possible states for a given board' do
      node = Node.new("X", [*0..2])
      directed_graph = described_class.new(node)
      binding.pry
      directed_graph.possibilities
      expect(directed_graph.game_tree).to match a_hash_including(
        {
          [0,1,2] => {
            ["X",1,2] => {
              ["X","O",2] => ["X","O","X"],
              ["X",1,"O"] => ["X","X","O"]
            },
            [0,"X",2] => {
              [0,"X","O"] => ["X","X","O"],
              ["O","X",2] => ["O","X","X"]
            },
            [0,1,"X"] => {
              [0,"O","X"] => ["X","O","X"],
              ["O",1,"X"] => ["O","X","X"]
            }
          }
        }
      )
    end
  end
end
