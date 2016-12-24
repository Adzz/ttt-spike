require_relative 'window.rb'
require_relative '../lib/board.rb'

class Game < Window
  def initialize
    super
    @position_x = cols / 2
    @position_y = lines / 2
  end

  def screen
    window.noutrefresh
    noecho
    window.box("|", "-")
    box = box(60,"|","~")
    window.noutrefresh
    draw_board

    begin
      while true
        command = getch
        case command
        when Curses::Key::DOWN
          @position_y += 4
          setpos(@position_y, @position_x)
        when Curses::Key::UP
          @position_y -= 4
          setpos(@position_y, @position_x)
        when Curses::Key::RIGHT
          @position_x += 6
          setpos(@position_y, @position_x)
        when Curses::Key::LEFT
          @position_x -= 6
          setpos(@position_y, @position_x)
        when Curses::Key::BACKSPACE
          addstr("X")
        end
      end
    ensure
      window.close
    end
  end

  private

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