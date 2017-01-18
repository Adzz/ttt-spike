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
      refresh
      render_board
      move_cursor
    end
  end

  private

  def_delegators :@curses,
    :display, :position_and_type_from_center, :refresh, :get_command, :user_response,
    :silent_keys, :add_border, :sub_window, :x_midpoint, :y_midpoint, :delete_char_under_cursor,
    :insert_char_before_cursor, :screen_columns, :screen_rows, :move_cursor_to, :type, :border

  def_delegator :@keyboard, :keys

  attr_reader :board

  def move_cursor
    while true
      command = get_command
      case command
      when keys[:down_arrow]
        @position_y += 4
        move_cursor_to(@position_y, @position_x)
      when keys[:up_arrow]
        @position_y -= 4
        move_cursor_to(@position_y, @position_x)
      when keys[:right_arrow]
        @position_x += 6
        move_cursor_to(@position_y, @position_x)
      when keys[:left_arrow]
        @position_x -= 6
        move_cursor_to(@position_y, @position_x)
      when keys[:x]
        type('X')
      when keys[:q]
        break
      when keys[:o]
        type('O')
      when keys[:d]
        delete_char_under_cursor
        insert_char_before_cursor(' ')
      end
    end
  end

  def render_board
    board.renderable_board.each_with_index do |board_line, index|
      position_and_type_from_center(board_line, (board.height/2)-index,0,0)
    end
    border("|", "~")
  end
end
