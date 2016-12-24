require_relative 'window.rb'
require_relative '../lib/board.rb'

class Game < Window
  def initialize
    super
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
      draw_board
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

  def draw_box(side, vertical_border, horizontal_border)
    box = window.subwin(side/2, side, ((lines-(side/2))/2), ((cols-side)/2))
    box.box(vertical_border, horizontal_border)

  end
end

# have enter be the choose move
# have the AI move show up somehow?