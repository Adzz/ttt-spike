class Node
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

  def initialize(player, current_state)
    validate_board(player, current_state)
    @player = player
    @current_state = current_state
    @rank = 0
  end
#  rank should be distance from a win
  attr_reader :current_state
  attr_accessor :rank

  def successors
    @successors ||= current_state.each_with_index.with_object([]) do |(value, index), successors|
      next unless value.is_a? Numeric
      possible_next_move = current_state.dup
      possible_next_move[index] = player
      successors << Node.new(other_player, possible_next_move)
    end
  end

  def winning?
    WINNING_LINES.each do |line|
      if current_state.values_at(*line) == [player, player, player]
        return true
      end
    end
    false
  end

  def winning_move_available?
    WINNING_LINES.each do |line|
      if (current_state.values_at(*line) - [player]).count == 1
        return true
      end
    end
    false
  end

  def about_to_lose?
    WINNING_LINES.each do |line|
      if (current_state.values_at(*line) - [other_player]).count == 1
        return true
      end
    end
    false
  end

  def losing?
    WINNING_LINES.each do |line|
      if current_state.values_at(*line) == [other_player, other_player, other_player]
        return true
      end
    end
    false
  end

  def drawing?
    (current_state - ["X"] - ["O"]).empty? && !losing(current_state) && !winning?(current_state)
  end

  private

  attr_reader :player

  def validate_board(player, current_state)
    x_count = current_state.select { |x| x == "X" }.count
    o_count = current_state.select { |o| o == "O" }.count
    return if x_count == 0 && o_count == 0 && player == "X"
    raise ArgumentError, "Illegal Board" if player == "O" && !current_state.include?("X")
    raise ArgumentError, "Illegal Board" if player == "X" && (x_count + 1) != (o_count + 1)
    raise ArgumentError, "Illegal Board" if player == "O" && (o_count + 1) != x_count
  end

  def other_player
    player == "O" ? "X" : "O"
  end
end
