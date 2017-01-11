require_relative '../../lib/curses/screen.rb'
require_relative '../../lib/board.rb'

class TwoPlayerGame
  extend Forwardable

  def initialize
    @curses = CursesWrapper::Screen.new
    @keyboard = CursesWrapper::Keyboard.new
    @board = Board.new
    @position_x = x_midpoint
    @position_y = y_midpoint
  end

  def screen
    display do
      silent_keys
      add_border("|", "-")
      draw_box(60,"|","~")
      refresh
      render_board
      move_cursor
    end
  end

  private

  def_delegators :@curses,
    :display, :position_and_type_from_center, :refresh, :get_command, :user_response,
    :silent_keys, :add_border, :sub_window, :bold_type, :x_midpoint, :y_midpoint,
    :delete_char_under_cursor, :insert_char_before_cursor, :screen_columns, :screen_rows

  def_delegator :@keyboard, :key

  attr_reader :board

  def move_cursor
    while true
      command = get_command
      case command
      when key(:down_arrow)
        @position_y += 4
        setpos(@position_y, @position_x)
      when key(:up_arrow)
        @position_y -= 4
        setpos(@position_y, @position_x)
      when key(:right_arrow)
        @position_x += 6
        setpos(@position_y, @position_x)
      when key(:left_arrow)
        @position_x -= 6
        setpos(@position_y, @position_x)
      when key(:x)
        bold_type('X')
      when key(:q)
        break
      when key(:o)
        bold_type('O')
      when key(:d)
        delete_char_under_cursor
        insert_char_before_cursor(' ')
      end
    end
  end

  def render_board
    board.renderable_board.each_with_index do |board_line, index|
      position_and_type_from_center(board_line, (board.height/2)-index,0,0)
    end
  end

  def draw_box(side, vertical_border, horizontal_border)
    sub_window(side/2, side, ((screen_rows - (side / 2)) / 2), ((screen_columns - side) / 2))
    add_border(vertical_border, horizontal_border)
  end
end
