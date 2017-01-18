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

  def initialize(state=[*0..8])
    @state = state
    @visual_board_lines = [
      "           |     |          ",
      "           |     |          ",
      "      _____|_____|_____     ",
      "           |     |          ",
      "           |     |          ",
      "      _____|_____|_____     ",
      "           |     |          ",
      "           |     |          ",
      "           |     |          "
    ]
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
    state
  end

  def renderable_board
    cells.each_with_index do |cell, index|
      visual_board_lines[cell[0]][cell[1]] = "X" if state[index] == "X"
      visual_board_lines[cell[0]][cell[1]] = "O" if state[index] == "O"
      visual_board_lines[cell[0]][cell[1]] = " " if state[index].is_a? Numeric
    end
    visual_board_lines
  end

  def height
    visual_board_lines.count
  end

  def width
    visual_board_lines.first.length
  end

  private

  attr_reader :visual_board_lines

  def cells
    @cells ||= [
      [1,8],[1,14],[1,20],
      [4,8],[4,14],[4,20],
      [7,8],[7,14],[7,20]
    ]
  end
end
