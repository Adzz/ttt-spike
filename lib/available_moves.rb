class AvailableMoves
  STARTING_POSITIONS = ["0,0", "0,1", "0,2","1,0", "1,1", "1,2" ,"2,0" ,"2,1", "2,2"]

  def second_players_first_moves(first_players_first_move)
    STARTING_POSITIONS - [first_players_first_move]
  end

  def state_after_each_first_move(starting_position)
    possible_state = []
    STARTING_POSITIONs.each do |first_move|
      second_players_first_moves(first_move)
    end
  end
end
