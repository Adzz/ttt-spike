require 'spec_helper'
require 'AI'

RSpec.describe AI do
  context 'When X' do
    subject { described_class.new("X") }

    it 'sends directed graph the choose move message' do
      expect(subject.next_move([*0..8])).to eq ["X",1,2,3,4,5,6,7,8]
    end
  end
end
