require 'curses'
require 'pry'

module CursesWrapper
  class Screen
    include Curses
    extend Forwardable

    def display
      begin
        Curses.nonl
        Curses.stdscr.keypad(true)
        Curses.raw
        Curses.init_screen
        yield
      ensure
        Curses.clear
        Curses.close_screen
      end
    end

    def_delegator :Curses, :noecho, :silent_keys
    def_delegator :Curses, :delch, :delete_char_under_cursor
    def_delegator :Curses, :inch, :char_under_cursor
    def_delegator :Curses, :getch, :get_command
    def_delegator :Curses, :lines, :screen_rows
    def_delegator :Curses, :cols, :screen_columns
    def_delegator :Curses, :insch, :insert_char_before_cursor
    def_delegator :Curses, :setpos, :move_cursor_to
    def_delegator :Curses, :addstr, :add_string
    def_delegator :Curses, :getstr, :get_string

    def_delegators :Curses, :clear, :refresh

    def y_midpoint
      screen_rows / 2
    end

    def x_midpoint
      screen_columns / 2
    end

    def type(string, speed=0.01)
      string.split("").each do |char|
        add_string(char)
        refresh
        sleep(speed)
      end
    end

    def user_response
      response = ""
      while response == ""
        position_and_type_from_center("")
        response = get_string
      end
      response
    end

    # the greater the y_axis_offset, the further UP the cursor is from screen center
    # the greater the x_axis_offset, the further RIGHT the cursor is from screen center
    def position_and_type_from_center(content='', y_axis_offset=0, x_axis_offset=0, speed=0.01)
      Curses.setpos(
        y_midpoint - y_axis_offset, ((screen_columns - content.length) / 2) + x_axis_offset
      )
      type(content, speed)
    end
  end
end
