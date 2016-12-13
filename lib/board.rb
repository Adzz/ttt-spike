class Board
  STARTING_POSITIONS = [*0..8]
  WINNING_LINES = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [2,4,6],
    [0,4,8],
    [1,4,7],
    [2,5,8]
  ]

  def available_positions(taken_positions)
    STARTING_POSITIONS - [taken_positions]
  end

  def winning_board?(board)
    WINNING_LINES.each do |line|
      return true if board.values_at(*line) == ["X","X","X"] ||
                     board.values_at(*line) == ["O","O","O"]
    end
    false
  end
end


