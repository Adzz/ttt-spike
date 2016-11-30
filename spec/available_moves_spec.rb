require 'spec_helper'
require 'available_moves.rb'

RSpec.describe AvailableMoves do
  describe "#second_players_first_moves" do
    FIRST_MOVES = ["0,0","0,1", "0,2","1,0", "1,1", "1,2" ,"2,0" ,"2,1", "2,2"]

    it 'returns all possible move combinations for any given starting position' do
      starting_position = FIRST_MOVES.sample
      expect(subject.second_players_first_moves(starting_position)).to eq FIRST_MOVES - [starting_position]
    end
  end
  describe "#state_after_each_first_move" do
    xit 'returns us all the possible states after one move each, given a first move' do
      expect(subject.state_after_each_first_move(FIRST_MOVES.sample))
    end
  end
end
