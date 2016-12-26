class Board
  BOARD_MAP = {
    game_state[0] => board_lines[1][8],
    game_state[1] => board_lines[1][14],
    game_state[2] => board_lines[1][20],
    game_state[3] => board_lines[4][8],
    game_state[4] => board_lines[4][14],
    game_state[5] => board_lines[4][20],
    game_state[6] => board_lines[7][8],
    game_state[7] => board_lines[7][14],
    game_state[8] => board_lines[7][20]
  }

  def initialize
    @board_lines = [
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

  def height
    board_lines.count
  end

  def width
    board_lines.first.length
  end

  def board
    board_lines.join("\n").to_s
  end

  def re_render_board(game_state)
    game_state.each_with_index do |position, index|
      board_lines.gsub!(BOARD_MAP[position])
    end
  end

  attr_reader :board_lines
end
