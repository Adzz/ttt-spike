require_relative '../game.rb'
require_relative '../../lib/ai.rb'

class OnePlayer < Game
  def initialize(player)
    super()
    @player = player
    @computer = AI.new(other_player)
  end

  def screen
    display do
      silent_keys
      refresh
      start_new_game
    end
  end

  private

  def start_new_game
    @board = Board.new
    board.render_board([*0..8])
    get_command
    player_move if player == "X"
    computer_move if player == "O"
  end

  attr_reader :player, :computer

  def player_move
    if board.game_over?
      sleep 2
      start_new_game
    end
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
    if board.game_over?
      sleep 2
      start_new_game
    end
    next_state = computer.move(board.state)
    position = (board.state - next_state).first
    board.update_state(position, other_player)
    player_move
  end

  def other_player
    player == "X" ? "O" : "X"
  end
end
