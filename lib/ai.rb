require_relative 'game_tree.rb'
require_relative 'game_state.rb'
require_relative 'board.rb'

class AI
  def initialize(player)
    @player = player
  end

  def move(game_state)
    paths = GameTree.new(GameState.new(player, Board.new(game_state))).weighted_paths
    paths.group_by do |path|
      path.game_states.first.current_state
    end.max_by do |_key, value|
      value.map(&:weight).inject(&:+)
    end.first
  end

  def choose_move
    return ["X",1,2,3,4,5,6,7,8] if game_state.current_state == [*0..8]

    grouped_paths.max_by do |_key, value|
      value.map(&:weight).inject(&:+)
    end.first
  end

  def grouped_paths
    weighted_paths.group_by do |path|
      path.game_states.first.current_state
    end
  end

  private

  attr_reader :player
end
