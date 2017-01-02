require_relative 'invoker.rb'
require_relative '../../views/game/one_player_game.rb'

class Client
  def initialize(view)
    @invoker = Invoker.new
    @view = view
  end

  def place_mark
    command = getch
    if return_key.include?(command)
      place_mark unless one_player_game.cursor_within_board?
      one_player_game.board.update_state(cursor_position_on_board, player)
      one_player_game.render_board
      one_player_game.computer_move
    end
  end

  private

  attr_reader :one_player_game, :invoker
end
