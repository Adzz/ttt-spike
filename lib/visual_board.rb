class VisualBoard
  def initialize
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

  def renderable_board(state)
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