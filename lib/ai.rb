require_relative 'directed_graph.rb'
require_relative 'node.rb'
require_relative 'board.rb'

class AI
  def initialize(player)
    @player = player
  end

  def move(game_state)
    DirectedGraph.new(Node.new(player, Board.new(game_state))).choose_move
  end

  private

  attr_reader :player
end
