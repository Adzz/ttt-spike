require_relative '../../lib/curses/screen.rb'
require_relative '../../lib/board.rb'
require_relative '../../lib/ai.rb'

class OnePlayerGame
  extend Forwardable

  INSTRUCTIONS = "Press r to reset the board Enter to place your mark, and q to quit the game".freeze


  def initialize(player)
    @curses = CursesWrapper::Screen.new
    @keyboard = CursesWrapper::Keyboard.new
    @player = player
    @computer = AI.new(other_player)
    @position_x = x_midpoint
    @position_y = y_midpoint
  end

  def screen
    display do
      silent_keys
      # window.box("|", "-")
      # draw_box(60,"|","~")
      start_new_game
    end
  end

  private

  def_delegators :@curses,
    :display, :position_and_type_from_center, :get_command,
    :silent_keys, :y_midpoint, :x_midpoint, :move_cursor_to, :refresh

  def_delegator :@keyboard, :keys

  def start_new_game
    @board = Board.new
    render_board
    player_move if player == "X"
    computer_move if player == "O"
  end

  attr_reader :board, :player, :computer

  def player_move
    #gameover screen if game_over?
    command = get_command
    case command
    when keys[:down_arrow]
      @position_y += 4
      move_cursor_to(@position_y, @position_x)
      player_move
    when keys[:up_arrow]
      @position_y -= 4
      move_cursor_to(@position_y, @position_x)
      player_move
    when keys[:right_arrow]
      @position_x += 6
      move_cursor_to(@position_y, @position_x)
      player_move
    when keys[:left_arrow]
      @position_x -= 6
      move_cursor_to(@position_y, @position_x)
      player_move
    when ->(command) { keys[:return_key].include?(command) }
      player_move unless cursor_within_board?
      board.update_state(cursor_position_on_board, player)
      render_board
      computer_move
    when keys[:q]
      exit
    when keys[:r]
      start_new_game
    else
      player_move
    end
  end

  def computer_move
    # if game_over?
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
    position_and_type_from_center(INSTRUCTIONS, -board.height, 0,0)
  end

  # def draw_box(side, vertical_border, horizontal_border)
  #   box = window.subwin(side/2, side, ((screen_rows-(side/2))/2), ((screen_columns-side)/2))
  #   box.box(vertical_border, horizontal_border)
  # end
end
