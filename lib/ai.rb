require 'directed_graph'
require 'node'

class AI
  def initialize(player)
    @player = player
  end

  def next_move(game_state)
    DirectedGraph.new(Node.new(player, game_state)).choose_move
  end

  private

  attr_reader :player
end
