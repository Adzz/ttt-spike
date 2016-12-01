class AvailableMoves
  STARTING_POSITIONS = [*0..8]
  # WINNING_LINES = 

  def available_positions(taken_positions)
    STARTING_POSITIONS - [taken_positions]
  end

  def winning_board?(board)
    board.values_at(0,1,2) == ["X","X","X"] ||
    board.values_at(3,4,5) == ["X","X","X"] ||
    board.values_at(6,7,8) == ["X","X","X"] ||
    board.values_at(0,4,8) == ["X","X","X"] ||
    board.values_at(2,4,6) == ["X","X","X"] ||
    board.values_at(0,3,6) == ["X","X","X"] ||
    board.values_at(1,4,7) == ["X","X","X"] ||
    board.values_at(2,5,8) == ["X","X","X"] ||

    board.values_at(0,1,2) == ["O","O","O"] ||
    board.values_at(3,4,5) == ["O","O","O"] ||
    board.values_at(6,7,8) == ["O","O","O"] ||
    board.values_at(0,4,8) == ["O","O","O"] ||
    board.values_at(2,4,6) == ["O","O","O"] ||
    board.values_at(0,3,6) == ["O","O","O"] ||
    board.values_at(1,4,7) == ["O","O","O"] ||
    board.values_at(2,5,8) == ["O","O","O"]
  end
end

