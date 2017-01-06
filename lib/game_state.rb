class GameState
  def initialize(player, board)
    @player = player
    @board = board
    validate_board(player, current_state)
  end

  attr_reader :board, :player

  def current_state
    board.state
  end

  def successors
    @successors ||= current_state.each_with_index.with_object([]) do |(value, index), successors|
      next unless value.is_a? Numeric
      possible_next_move = current_state.dup
      possible_next_move[index] = player
      successors << GameState.new(other_player, Board.new(possible_next_move))
    end
  end

  def won?
    board.winning_board_for?(player)
  end

  def lost?
    board.winning_board_for?(other_player)
  end

  def game_over?
    won? || lost? || (current_state - [player] - [other_player]).count == 0
  end

  private
#  this should be run everytime we change a board's state, probably in the board class?
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
