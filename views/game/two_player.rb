require_relative '../../lib/curses/screen.rb'
require_relative '../../lib/board.rb'

class TwoPlayerGame
  extend Forwardable

  INSTRUCTIONS = "Press r to reset the board, Enter to place your mark, and q to quit the game".freeze

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
      play_game
    end
  end

  private

  def_delegators :@curses,
    :type,
    :border,
    :display,
    :refresh,
    :x_midpoint,
    :y_midpoint,
    :get_command,
    :silent_keys,
    :move_cursor_to,
    :delete_char_under_cursor,
    :insert_char_before_cursor,
    :position_and_type_from_center

  def_delegator :@keyboard, :keys

  attr_reader :board

  def play_game
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
        play_game unless cursor_within_board?
        type('X')
      when keys[:q]
        break
      when keys[:o]
        play_game unless cursor_within_board?
        type('O')
      when keys[:d]
        delete_char_under_cursor
        insert_char_before_cursor(' ')
      end
    end
  end

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
    board.renderable_board.each_with_index do |board_line, index|
      position_and_type_from_center(board_line, (board.height/2)-index,0,0)
    end
    border("|", "~")
    position_and_type_from_center(INSTRUCTIONS, -board.height, 0,0)
  end
end
