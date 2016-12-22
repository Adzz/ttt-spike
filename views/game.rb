require_relative 'window.rb'

class Game < Window
  include Curses

  def screen
    window.refresh
    window.box("|", "-")
    board(60,"|","~")
    window.refresh
    getstr
  end

  private

  def board(side, vertical_border, horizontal_border)
    board = window.subwin(side/2, side, ((lines-(side/2))/2), ((cols-side)/2))
    board.box(vertical_border, horizontal_border)
  end
end
