require_relative '../lib/board.rb'
require_relative '../lib/curses/screen.rb'

class Game
  extend Forwardable

  INSTRUCTIONS = "Press r to reset the board, Enter to place your mark, and q to quit the game".freeze

  def initialize(*)
    @curses = CursesWrapper::Screen.new
    @keyboard = CursesWrapper::Keyboard.new
    @position_x = x_midpoint
    @position_y = y_midpoint
    @visual_board = VisualBoard.new
    @board = Board.new(visual_board: visual_board)
  end

  private

  attr_reader :board, :visual_board

  def_delegators :@curses,
    :border,
    :display,
    :refresh,
    :y_midpoint,
    :x_midpoint,
    :get_command,
    :silent_keys,
    :move_cursor_to,
    :position_and_type_from_center

  def_delegator :@keyboard, :keys

  def cursor_within_board?
    cells.include?([@position_y, @position_x])
  end

  def cursor_position_on_board
    cells.rindex { |cell| cell == [@position_y, @position_x] }
  end

  def cells
    [
      [ y_midpoint - 4, x_midpoint - 6 ],
      [ y_midpoint - 4, x_midpoint ],
      [ y_midpoint - 4, x_midpoint + 6 ],
      [ y_midpoint, x_midpoint - 6 ],
      [ y_midpoint, x_midpoint ],
      [ y_midpoint, x_midpoint + 6 ],
      [ y_midpoint + 4, x_midpoint - 6 ],
      [ y_midpoint + 4, x_midpoint ],
      [ y_midpoint + 4, x_midpoint + 6 ]
    ]
  end

  def render_board
    visual_board.renderable_board(board.state).each_with_index do |board_line, index|
      position_and_type_from_center(board_line, (visual_board.height/2)-index,0,0)
    end
    border("|", "~")
    position_and_type_from_center(INSTRUCTIONS, -visual_board.height, 0,0)
  end
end