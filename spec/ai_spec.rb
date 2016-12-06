require 'spec_helper'
require 'ai.rb'
require 'directed_graph'

# For testing, we just have to be sure that we can win or not lose from every possible
# starting state - going first and going second.
# How many levels deep do we need to go before we know for sure we aren't going to lose?


RSpec.describe AI do
  describe '#next_move' do
    subject { described_class.new(DirectedGraph.new) }

    it 'selects the winning move when there is one' do
      board = ["X","X",2,3,4,5,"O",7,"O"]
      expect(subject.next_move(board)).to eq ["X","X","X",3,4,5,"O",7,"O"]
    end
  end
end
