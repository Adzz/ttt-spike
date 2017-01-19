require_relative '../game.rb'

class TwoPlayer < Game
  def screen
    display do
      silent_keys
      refresh
      render_board
      play_game
    end
  end

  private

  def_delegators :@curses, :type, :delete_char_under_cursor, :insert_char_before_cursor

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
end
