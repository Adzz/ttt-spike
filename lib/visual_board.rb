require_relative '../lib/curses/screen.rb'

class VisualBoard
  INSTRUCTIONS = "Press enter to place your mark, r to reset the board and q to quit".freeze

  attr_reader :visual_board_lines, :view

  def initialize(view: CursesWrapper::Screen.new)
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
    @view = view
  end

  def render_board(state)
    cells.each_with_index do |cell, index|
      visual_board_lines[cell[0]][cell[1]] = "X" if state[index] == "X"
      visual_board_lines[cell[0]][cell[1]] = "O" if state[index] == "O"
      visual_board_lines[cell[0]][cell[1]] = " " if state[index].is_a? Numeric
    end
    render(visual_board_lines)
  end

  def height
    visual_board_lines.count
  end

  def width
    visual_board_lines.first.length
  end

  private

  def render(visual_board_lines)
    visual_board_lines.each_with_index do |board_line, index|
      view.position_and_type_from_center(board_line, (height / 2) - index, 0, 0)
    end
    view.border("|", "~")
    view.position_and_type_from_center(INSTRUCTIONS, - height, 0, 0)
  end

  def cells
    @cells ||= [
      [1,8],[1,14],[1,20],
      [4,8],[4,14],[4,20],
      [7,8],[7,14],[7,20]
    ]
  end
end
