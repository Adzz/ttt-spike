require_relative '../window.rb'
require_relative '../../lib/board.rb'
require_relative '../../lib/ai.rb'

class OnePlayerGame < Window

  def initialize(player)
    super
    @board = Board.new
    @player = player
    @computer = AI.new(other_player)
    @position_x = x_midpoint
    @position_y = y_midpoint
  end

  def screen
     begin
      window.noutrefresh
      noecho
      window.box("|", "-")
      draw_box(60,"|","~")
      window.noutrefresh
      start_new_game
      getch
    ensure
      window.close
    end
  end

  private

  def start_new_game
    [*0..8].each { |pos| board.update_state(pos, pos) }
    render_board
    window.noutrefresh
    player_move if player == "X"
    computer_move if player == "O"
  end

  attr_reader :board, :player, :computer

  def player_move
    command = getch
    if command == Curses::Key::DOWN
      @position_y += 4
      setpos(@position_y, @position_x)
      player_move
    elsif command == Curses::Key::UP
      @position_y -= 4
      setpos(@position_y, @position_x)
      player_move
    elsif command == Curses::Key::RIGHT
      @position_x += 6
      setpos(@position_y, @position_x)
      player_move
    elsif command == Curses::Key::LEFT
      @position_x -= 6
      setpos(@position_y, @position_x)
      player_move
    elsif return_key.include?(command)
      player_move unless cursor_within_board?
      board.update_state(cursor_position_on_board, player)
      render_board
      computer_move
    elsif command == ?q
      exit
    elsif command == ?r
      start_new_game
    else
      player_move
    end
  end

  def computer_move
    next_state = computer.move(board.state)
    position = (board.state - next_state).first
    board.update_state(position, other_player)
    render_board
    player_move
  end

  def other_player
    player == "X" ? "O" : "X"
  end

  def cursor_within_board?
    cells.include?([@position_y, @position_x])
  end

  def cursor_position_on_board
    cells.rindex { |cell| cell == [@position_y, @position_x] }
  end

  def cells
    [
      [ y_midpoint - 4, x_midpoint - 6 ],
      [ y_midpoint - 4, x_midpoint ],
      [ y_midpoint - 4, x_midpoint + 6 ],
      [ y_midpoint, x_midpoint - 6 ],
      [ y_midpoint, x_midpoint ],
      [ y_midpoint, x_midpoint + 6 ],
      [ y_midpoint + 4, x_midpoint - 6 ],
      [ y_midpoint + 4, x_midpoint ],
      [ y_midpoint + 4, x_midpoint + 6 ]
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
