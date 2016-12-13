require 'pry'
require 'path.rb'
require 'player.rb'

class AI_X
  include Player

  def initialize(game_tree)
    @player = "X"
    @game_tree = game_tree
    @paths = []
  end

  def next_move(game_state)
    return ["X",1,2,3,4,5,6,7,8] if game_state.count < 2
    possible_moves = game_tree.dig(*game_state)
    create_paths(possible_moves)
    evaluate(paths)
    binding.pry
  end

  private

  def create_paths(possible_moves)
    possible_moves.each do |key, value|
      path = Path.new
      path.tree= { key => value }
      paths << path
    end
  end

  def evaluate(paths)
    paths.each do |path|
      end_state = end_state(path.tree)
      binding.pry
      if winner?(end_state)
        path.weight= 10 
      elsif loser?(end_state)
        path.weight= -10
      else
        path.weight= 0
      end
    end
  end

  def end_state(path_tree)
    # get end state for each path
  end

  attr_reader :player, :game_tree, :paths
end
