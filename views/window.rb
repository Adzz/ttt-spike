require 'curses'

class Window
  include Curses

  def initialize(height=0, width=0, top=0, left=0)
    @window = Curses::Window.new(0,0,0,0)
    stdscr.keypad(true)
  end

  def type(string, speed=0)
    string.split("").each do |char|
      addstr(char)
      refresh
      sleep(speed)
    end
  end

  def screen
    raise NotImplementedError
  end

  def user_response
    response = ''
    while response == ''
      position_and_type_from_center('', window.cury, window.curx)
      response = getstr
    end
    response
  end

  # the bigger the y_axis_offset, the further UP the cursor is from screen center
  # the bigger the x_axis_offset, the further RIGHT the cursor is from screen center
  def position_and_type_from_center(content='', y_axis_offset=0, x_axis_offset=0, speed=0)
    setpos((lines / 2) - y_axis_offset, ((cols - content.length) / 2) + x_axis_offset)
    type(content, speed)
  end

  private

  attr_reader :window
end