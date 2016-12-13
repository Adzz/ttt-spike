require 'pry'
require 'path.rb'

module Player
  class AI_X
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
    end

    private

    def create_paths(possible_moves)
      possible_moves.each do |key, value|
        path = Path.new.tree= { key => value }
        paths << path
      end
    end

    def evaluate(paths)
      paths.each do |path|
        evaluate(path) if path.is_a? Hash

        path.weight= 10 if winner?(value)
        path.weight= -10 if loser?(value)
        path.weight= 0 if draw?(value)
      end
    end

    attr_reader :player, :game_tree, :paths
  end
end
