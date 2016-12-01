#!/usr/local/bin/ruby

require "curses"
include Curses

class Welcome
  WELCOME_STRING = "Hello stranger, what is your name?"

  def game
    init_screen
    cbreak
    welcome
    get_name
    answer = getch
    if answer == "y"
      addstr("Okay!")
      getch
    else
      end_game
    end
  end

  private

  def welcome
    position_and_type(WELCOME_STRING, -4)
    move_down(-2)
  end

  def get_name
    name = getstr
    position_and_type("Welcome #{name}, shall we play a game?")
    move_down(2)
    type("y/n")
  end

  def end_game
    win = Curses::Window.new(0,0,0,0)
    win.refresh
    position_and_type("Too Bad....")
    win.getch
    close_screen
  end

  def type(string)
    string.split("").each do |char|
      addstr(char)
      refresh
      # sleep(0.1)
    end
  end

  def position_and_type(content, x_offset_center=0, y_offset_center=0)
    setpos((lines / 2) + x_offset_center, ((cols - content.length) / 2) - y_offset_center)
    type(content)
  end

  def move_down(number)
    setpos((lines / 2) + number, (cols / 2))
  end
end

Welcome.new.game

#  make a class. This can be the board drawer class. When we init the game we can Just call Game.init and have the curses stuff happen