require_relative '../window.rb'
require_relative '../../lib/board.rb'
require_relative '../../lib/ai.rb'

class OnePlayerGame < Window

  def initialize(player)
    super
    @board = Board.new
    @player = player
    @computer = AI.new(other_player)
    @position_x = screen_columns / 2
    @position_y = screen_rows / 2
  end

  def screen
     begin
      window.noutrefresh
      noecho
      window.box("|", "-")
      draw_box(60,"|","~")
      window.noutrefresh
      render_board
      next_move
      getch
    ensure
      window.close
    end
  end

  private

  attr_reader :board, :player, :computer

  def next_move
    command = getch
    if command == Curses::Key::DOWN
      @position_y += 4
      setpos(@position_y, @position_x)
      next_move
    elsif command == Curses::Key::UP
      @position_y -= 4
      setpos(@position_y, @position_x)
      next_move
    elsif command == Curses::Key::RIGHT
      @position_x += 6
      setpos(@position_y, @position_x)
      next_move
    elsif command == Curses::Key::LEFT
      @position_x -= 6
      setpos(@position_y, @position_x)
      next_move
    elsif return_key.include?(command)
      next_move unless cursor_within_board?
      board.update_state(cursor_position, player)
      render_board
      next_move
    elsif command == ?q
      exit
    else
      next_move
    end
  end

  def other_player
    player == "X" ? "O" : "X"
  end

  def cursor_within_board?
    cells.include?([@position_y, @position_x])
  end

  def cursor_position
    cells.rindex { |cell| cell == [@position_y, @position_x] }
  end

  def cells
    [
      [((screen_rows / 2) - 4), ((screen_columns / 2) - 6)],
      [((screen_rows / 2) - 4), (screen_columns / 2)],
      [((screen_rows / 2) - 4), ((screen_columns / 2) + 6)],
      [(screen_rows / 2), ((screen_columns / 2) - 6)],
      [(screen_rows / 2), (screen_columns / 2)],
      [(screen_rows / 2), ((screen_columns / 2) + 6)],
      [((screen_rows / 2) + 4), ((screen_columns / 2) - 6)],
      [((screen_rows / 2) + 4), (screen_columns / 2)],
      [((screen_rows / 2) + 4), ((screen_columns / 2) + 6)]
    ]
  end

  def render_board
    board.renderable_board.each_with_index do |board_line, index|
      position_and_type_from_center(board_line, (board.height/2)-index,0,0)
    end
  end

  def draw_box(side, vertical_border, horizontal_border)
    box = window.subwin(side/2, side, ((screen_rows-(side/2))/2), ((screen_columns-side)/2))
    box.box(vertical_border, horizontal_border)
  end
end
