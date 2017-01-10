require 'curses'
require 'pry'

module CursesWrapper
  class Screen
    include Curses

    def initilaize(height=0, width=0, top=0, left=0)
      @window = Curses::Window.new(0,0,0,0)
    end

    attr_reader :window

    def display(&block)
      begin
        Curses.nonl
        Curses.stdscr.keypad(true)
        Curses.raw
        Curses.init_screen
        yield self
      ensure
        Curses.clear
        Curses.close_screen
      end
    end

    def bold_type(text)
      Curses.attron(color_pair(COLOR_BLUE)|A_BOLD) do
        text
      end
    end

    def silent_keys
      Curses.noecho
    end

    def clear
      Curses.clear
    end

    def refresh
      Curses.refresh
    end

    def get_char
      Curses.getch
    end

    def screen_rows
      Curses.lines
    end

    def screen_columns
      Curses.cols
    end

    def y_midpoint
      screen_rows / 2
    end

    def x_midpoint
      screen_columns / 2
    end

    def return_key
      [KEY_ENTER, 10, 13]
    end

    def type(string, speed=0.01)
      string.split("").each do |char|
        Curses.addstr(char)
        Curses.refresh
        sleep(speed)
      end
    end

    def user_response
      response = ""
      while response == ""
        position_and_type_from_center("")
        response = Curses.getstr
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
