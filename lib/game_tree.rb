class GameTree
  PATH = Struct.new(:game_states, :weight) do
    def initialize(*)
        super
        self.game_states ||= []
        self.weight ||= 0
    end
  end

  def initialize(game_state)
    @game_state = game_state
  end

  def choose_move
    return ["X",1,2,3,4,5,6,7,8] if game_state.current_state == [*0..8]
    best_move
  end

  private

  attr_reader :game_state

  def best_move
    grouped_paths.max_by do |_key, value|
      value.map(&:weight).inject(&:+)
    end.first
  end

  def grouped_paths
    weighted_paths.group_by do |path|
      path.game_states.first.current_state
    end
  end

  def weighted_paths
    routes.each_with_object([]) do |route, paths|
      path = PATH.new
      game_states = [
        game_state.successors[route.first]
      ]

      route.drop(1).each do |game_state_location|
        first_game_state = game_states.pop
        game_states.push(first_game_state)
        next_game_state = first_game_state.successors[game_state_location]
        game_states.push(next_game_state)

        # if first_game_state.won?
        #   path.weight= (100 - game_states.length)
        #   break
        # end

        # if first_game_state.lost?
        #   path.weight= (- (100 - game_states.length))
        #   break
        # end

        # if next_game_state.lost?
        #   if first_game_state.player == game_state.player
        #     path.weight= (100 - game_states.length)
        #   else
        #     path.weight= (- (100 - game_states.length))
        #   end
        #   break
        # end

        if first_game_state.lost?
          path.weight= (100 - game_states.length)
          break
        elsif first_game_state.won?
          path.weight= (- (100 - game_states.length))
          break
        elsif next_game_state.lost?
          if first_game_state.player == game_state.player
            path.weight= (100 - game_states.length)
          else
            path.weight= (- (100 - game_states.length))
          end
          break
        else
          game_states.push(next_game_state)
        end
      end

      path.game_states= game_states
      paths << path
    end
  end

  def routes
    routes = []
    free_moves = (board - ["X"] - ["O"])
    free_moves.each_with_index do |_pos, index|
      routes << [*0.. (free_moves.length - (index + 1))]
    end
    routes.first.product(*routes[1..-1])
  end

  def board
    game_state.current_state
  end
end
