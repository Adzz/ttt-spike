require "curses"

class Welcome
  include Curses

  WELCOME_STRING = "Hello stranger, what is your name?"

  def game
    init_screen
    cbreak
    welcome_message
    get_name
    invite
    answer = getch
    if answer == "y"
      addstr("Okay!")
      getch
    else
      end_game
    end
  end

  private

  def welcome_message
    position_and_type_from_center(WELCOME_STRING,4)
  end

  def get_name
    position_and_type_from_center('',2)
    @name = getstr
  end

  def invite
    position_and_type_from_center("Welcome #{@name}, shall we play a game?")
    @reply = getstr
    if @reply == "Love to. How about Global Thermonuclear War?"
      position_and_type_from_center("Wouldn't you prefer a nice game of Tic Tac Toe?",-4)
    else
      position_and_type_from_center("y/n",-2)
    end
  end

  def end_game
    win = Curses::Window.new(0,0,0,0)
    win.refresh
    position_and_type_from_center("Too Bad....")
    win.getch
    close_screen
  end

  def type(string)
    string.split("").each do |char|
      addstr(char)
      refresh
      sleep(0.1)
    end
  end

  # the bigger the y_axis_offset, the further UP the cursor is from screen center
  # the bigger the x_axis_offset, the further RIGHT the cursor is from screen center
  def position_and_type_from_center(content=[], y_axis_offset=0, x_axis_offset=0)
    setpos((lines / 2) - y_axis_offset, ((cols - content.length) / 2) + x_axis_offset)
    type(content)
  end
end
