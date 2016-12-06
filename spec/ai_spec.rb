require 'spec_helper'
require 'ai.rb'
require 'directed_graph'

RSpec.describe AI do
  describe '#next_move' do
    subject { described_class.new(DirectedGraph.new) }

    xit 'selects the winning move when there is one' do
      board = ["X","X",2,3,4,5,"O",7,"O"]
      expect(subject.next_move(board)).to eq ["X","X","X",3,4,5,"O",7,"O"]
    end

    it 'selects top left when taking the first go' do
      board = [*0..8]
      expect(subject.next_move(board)).to eq ["X",1,2,3,4,5,6,7,8]
    end

    it 'selects top left when taking the first go' do
      board = [*0..8]
      expect(subject.next_move(board)).to eq ["X",1,2,3,4,5,6,7,8]
    end
  end
end
