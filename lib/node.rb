class Node
  def initialize(player, current_state)
    validate_board(player, current_state)
    @player = player
    @current_state = current_state
  end

  attr_reader :current_state

  def successors
    @successors ||= current_state.each_with_index.with_object([]) do |(value, index), successors|
      next unless value.is_a? Numeric
      possible_next_move = current_state.dup
      possible_next_move[index] = player
      successors << Node.new(other_player, possible_next_move)
    end
  end

  private 

  attr_reader :player

  def validate_board(player, current_state)
    x_count = current_state.select { |x| x == "X" }.count
    o_count = current_state.select { |o| o == "O" }.count
    return if x_count == 0 && o_count == 0 && player == "X"
    raise IllegalBoard if player == "O" && !current_state.include?("X")
    raise IllegalBoard if player == "X" && (x_count + 1) != (o_count + 1)
    raise IllegalBoard if player == "O" && (o_count + 1) != x_count
  end

  def other_player
    player == "O" ? "X" : "O"
  end
end

class IllegalBoard < StandardError
end
