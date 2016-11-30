#!/usr/local/bin/ruby

require "curses"
include Curses

init_screen
start_color()
cbreak

def center(content=[])
  setpos((lines / 2), (cols - content.length) / 2)
end

def type(string)
  string.split("").each do |char|
    addstr(char)
    refresh
    sleep(0.1)
  end
end

def position_and_type(content, lower=0, left=0)
  setpos((lines / 2) + lower, ((cols - content.length) / 2) - left)
  type(content)
end

def move_down(number)
  setpos((lines / 2) + number, (cols / 2))
end

WELCOME_STRING = "Hello stranger, what is your name?"

position_and_type(WELCOME_STRING)

move_down(2)

name = getstr

position_and_type("Welcome #{name}, shall we play a game?", 4)

getch
close_screen

#  make a class. This can be the board drawer class. When we init the game we can Just call Game.init and have the curses stuff happen