
module ScreenHelper
  def type(string, speed=0.01)
    string.split("").each do |char|
      Curses.addstr(char)
      Curses.refresh
      sleep(speed)
    end
  end

  def return_key
    [KEY_ENTER, 10, 13]
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