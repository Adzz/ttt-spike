#!/usr/bin/env ruby

require "curses"
include Curses

init_screen
# start_color
# init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_WHITE)
# init_pair(COLOR_RED,COLOR_RED,COLOR_WHITE)
# crmode
noecho
stdscr.keypad(true)

# begin
  # mousemask(BUTTON1_CLICKED|BUTTON2_CLICKED|BUTTON3_CLICKED|BUTTON4_CLICKED)
  # setpos((lines - 5) / 2, (cols - 10) / 2)
  # attron(color_pair(COLOR_BLUE)|A_BOLD){
  #   addstr("click")
  # }
  # refresh

  while( true )
    c = getch
    case c
    when KEY_DOWN
      setpos(10,10)
    when KEY_UP
      addstr("up")
    when KEY_LEFT
      addstr("left")
    when KEY_RIGHT
      addstr("right")
    end
  end

#   refresh
# ensure
#   close_screen
# end