class Player
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
      return true if board.values_at(*line) == [player, player, player]
    end
    false
  end

  def loser?(board)
    WINNING_LINES.each do |line|
      return true if board.values_at(*line) == [other_player, other_player, other_player]
    end
    false
  end
end

class AI < Player
  def next_move(board)
    raise NotImplementedError
  end

  def player
    raise NotImplementedError
  end
end

class AI_X < AI
  def player
    "X"
  end

  def next_move(board)
    return ["X",1,2,3,4,5,6,7,8] unless board.include?(player)
  end
end

class AI_O < AI
  def player
    "O"
  end

  def next_move(board)
    game_tree[board]
  end
end


