class AvailableMoves
  STARTING_POSITIONS = [*0..8]

  def available_positions(taken_positions)
    STARTING_POSITIONS - [taken_positions]
  end

  def state_after_each_first_move(starting_position)
    possible_state = []
    STARTING_POSITIONs.each do |first_move|
    end
  end
end
