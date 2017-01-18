class Board
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

  attr_reader :state

  def initialize(state: [*0..8], visual_board: VisualBoard.new)
    @state = state
    @visual_board = visual_board
  end

  def game_over?
    winning_board_for?("X") || winning_board_for?("O") || (state - ["X"] - ["O"]).count == 0
  end

  def winning_board_for?(player)
    WINNING_LINES.each do |line|
      if state.values_at(*line) == [player, player, player]
        return true
      end
    end
    false
  end

  def update_state(position, player)
    state[position] = player
    visual_board.renderable_board(state)
    state
  end

  private

  attr_reader :visual_board
end
