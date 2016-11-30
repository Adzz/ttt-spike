require 'spec_helper'
require 'available_moves.rb'

RSpec.describe AvailableMoves do
  describe "#available_positions" do
    FIRST_MOVES = [*0..8]

    it 'returns all possible move combinations for any given starting position' do
      starting_position = FIRST_MOVES.sample
      expect(subject.available_positions(starting_position)).to eq FIRST_MOVES - [starting_position]
    end
  end

  describe "#state_after_each_first_move" do
    xit 'returns us all the possible states after one move each, given a first move' do
      expect(subject.state_after_each_first_move(FIRST_MOVES.sample))
    end
  end
end
