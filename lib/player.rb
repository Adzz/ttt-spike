module Player
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

  def winner?(board)
    WINNING_LINES.each do |line|
      return true if (board.values_at(*line) & [player, player, player]).any?
    end
    false
  end

  def loser?(board)
    WINNING_LINES.each do |line|
      return true if board.values_at(*line) == [other_player, other_player, other_player]
    end
    false
  end

  def draw?(board)
    (board - ["X"] - ["O"]).empty? && !loser(board) && !winner?(board)
  end

  def other_player
    player == "O" ? "X" : "O"
  end
end
