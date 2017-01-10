require_relative '../screen.rb'
require_relative '../../lib/board.rb'

class TwoPlayerGame
  def initialize
    super
    @window = Screen.new
    @board = Board.new
    @position_x = cols / 2
    @position_y = lines / 2
  end

  def screen
    begin
      window.noutrefresh
      noecho
      window.box("|", "-")
      draw_box(60,"|","~")
      window.noutrefresh
      render_board
      move_cursor
    ensure
      window.close
    end
  end

  private

  attr_reader :board, :window

  def move_cursor
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
      when ?x
        attron(color_pair(COLOR_BLUE)|A_BOLD){
          addstr("X")
        }
      when ?q
        break
      when ?o
        attron(color_pair(COLOR_BLUE)|A_BOLD){
          addstr("O")
        }
      when ?d
        delch
        insch(" ")
      end
    end
  end

  def render_board
    board.renderable_board.each_with_index do |board_line, index|
      position_and_type_from_center(board_line, (board.height/2)-index,0,0)
    end
  end

  def draw_box(side, vertical_border, horizontal_border)
    box = window.subwin(side/2, side, ((lines-(side/2))/2), ((cols-side)/2))
    box.box(vertical_border, horizontal_border)
  end
end
