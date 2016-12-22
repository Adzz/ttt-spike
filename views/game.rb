require_relative 'window.rb'
require_relative '../lib/board.rb'

class Game < Window
  include Curses

  def screen
    window.refresh
    noecho
    window.box("|", "-")
    board = board(60,"|","~")
    window.refresh
    Board.new.board_lines.each_with_index do |board_line, index|
      position_and_type_from_center(board_line, -index)
    end
    getstr
  end

  private

  def board(side, vertical_border, horizontal_border)
    board = window.subwin(side/2, side, ((lines-(side/2))/2), ((cols-side)/2))
    board.box(vertical_border, horizontal_border)
  end
end

# to do
#  draw the actual board
#     6 subwindows? Positioned? then have the cursor move to each one?
#     have the character be placed in the center of it
# moving the cursor around.
# have enter be the choose move
# have the AI move show up somehow?!