require 'pry'

module Player
  class AI_X
    def initialize(game_tree)
      @player = "X"
      @game_tree = game_tree
    end

    def next_move(game_state)
      return ["X",1,2,3,4,5,6,7,8] if game_state.count < 2
      possible_moves = game_tree.dig(*game_state)
      evaluate(possible_moves)
    end

    private

    def evaluate(possible_moves)
      possible_moves.each do |key, path|
        evaluate(path) if value.is_a? Hash
        path_weight= 10 if winner?(value)
        path_weight= -10 if loser?(value)
        path_weight= 0 if draw?(value)
      end
    end

    attr_reader :player, :game_tree
  end
end
