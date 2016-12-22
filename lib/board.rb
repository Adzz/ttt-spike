class Board
  def initialize
    @board_lines = [
      "   |    |   ",
      "___|____|___",
      "   |    |   ",
      "___|____|___",
      "   |    |   ",
      "   |    |   "
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

  attr_reader :board_lines
end
