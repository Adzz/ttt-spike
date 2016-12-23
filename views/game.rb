require_relative 'window.rb'
require_relative '../lib/board.rb'

class Game < Window
  def screen
    window.refresh
    noecho
    window.box("|", "-")
    box = box(60,"|","~")
    window.refresh
    draw_board
    getch
    command = getch
    case command
    when KEY_UP then move(0,-1)
    when KEY_DOWN then move(0,1)
    when KEY_RIGHT then move(1,0)
    when KEY_LEFT then move(-1,0)
    end
    getstr
  end
# can scroll up instead of redrawing
  private

  def move(x,y)
    @position_x = window.curx
    @position_y = window.cury
    setpos(@position_y+=x, @position_x+=y)
  end

  def board
    @board ||= Board.new
  end

  def draw_board
    board.board_lines.each_with_index do |board_line, index|
      position_and_type_from_center(board_line, (board.height/2)-index)
    end
  end

  def box(side, vertical_border, horizontal_border)
    box = window.subwin(side/2, side, ((lines-(side/2))/2), ((cols-side)/2))
    box.box(vertical_border, horizontal_border)
  end
end

# to do
#  draw the actual board
#     6 subwindows? Positioned? then have the cursor move to each one?
#     have the character be placed in the center of it
# moving the cursor around
# have enter be the choose move
# have the AI move show up somehow?