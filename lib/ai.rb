require_relative 'game_tree.rb'
require_relative 'game_state.rb'
require_relative 'board.rb'

class AI
  def initialize(player)
    @player = player
  end

  def move(game_state)
    GameTree.new(GameState.new(player, Board.new(game_state))).choose_move
  end

  private

  attr_reader :player
end
