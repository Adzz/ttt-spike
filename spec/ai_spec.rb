require 'spec_helper'
require 'AI'

RSpec.describe AI do
  context 'When X' do
    subject { described_class.new("X") }

    it 'selects an optimal first move for X' do
      expect(subject.next_move([*0..8])).to eq ["X",1,2,3,4,5,6,7,8]
    end

    it 'selects a winning move for X when there is one' do
      expect(subject.next_move(["X","O","X",3,"O",5,"O",7,"X"])).to eq ["X","O","X",3,"O","X","O",7,"X"]
    end
  end
end
