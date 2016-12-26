require_relative '../window.rb'
require_relative '../../lib/board.rb'

class OnePlayerGame < Window
  def initialize(player, computer)
    super
    @board = Board.new
    @player = player
    @computer = AI.new(other_player)
  end

  def screen
     begin
      setup
      window.box("|", "-")
      draw_box(60,"|","~")
      window.noutrefresh
      draw_board
      play_game
    ensure
      window.close
    end
  end

  private

  attr_reader :board, :player, :computer

  def play_game
    x_goes
    o_goes
    play_game
  end

  def other_player
    player == "O" ? "X" : "O"
  end

  def setup
    window.noutrefresh
    noecho
  end

  def render_board(game_state)
    board.board_lines.each_with_index do |board_line, index|
      position_and_type_from_center(board_line, (board.height/2)-index)
    end
  end

  def draw_box(side, vertical_border, horizontal_border)
    box = window.subwin(side/2, side, ((lines-(side/2))/2), ((cols-side)/2))
    box.box(vertical_border, horizontal_border)
  end
end