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

  def weighted_paths
    routes.each_with_object([]) do |route, paths|
      path = PATH.new
      game_states = [
        game_state.successors[route.first]
      ]

      # route.drop(1).each do |game_state_location|
      #   first_game_state = game_states.pop
      #   game_states.push(first_game_state)
      #   next_game_state = first_game_state.successors[game_state_location]
      #   game_states.push(next_game_state)

      #   if first_game_state.lost?
      #     path.weight= (100 - game_states.length)
      #     break
      #   elsif first_game_state.won?
      #     path.weight= (- (100 - game_states.length))
      #     break
      #   elsif next_game_state.lost?
      #     if first_game_state.player == game_state.player
      #       path.weight= (100 - game_states.length)
      #     else
      #       path.weight= (- (100 - game_states.length))
      #     end
      #     break
      #   else
      #     game_states.push(next_game_state)
      #   end
      # end

      # path.game_states= game_states
      # paths << path
      # Cant see why the above works, but this does not:
      paths << evaluate(generated_path(game_states, PATH.new, route))
    end
  end

  def choose_move
    return ["X",1,2,3,4,5,6,7,8] if game_state.current_state == [*0..8]

    grouped_paths.max_by do |_key, value|
      value.map(&:weight).inject(&:+)
    end.first
  end

  private

  attr_reader :game_state

  def grouped_paths
    weighted_paths.group_by do |path|
      path.game_states.first.current_state
    end
  end


  def generated_path(game_states, path, route, iterator=1)
    first_game_state = game_states.pop
    game_states.push(first_game_state)
    path.game_states= game_states; return path if first_game_state.game_over?
    next_game_state = first_game_state.successors[route[iterator]]
    game_states.push(next_game_state)
    path.game_states= game_states; return path if next_game_state.game_over?
    generated_path(game_states, path, route, iterator+=1)
  end

  def evaluate(path)
    final_state = path.game_states.last
    path.weight= (100 - path.game_states.length) if win_for_us?(final_state)
    path.weight= (- (100 - path.game_states.length)) if loss_for_us?(final_state)
    path
  end

  def routes
    routes = []
    free_moves = (board - ["X"] - ["O"])
    free_moves.each_with_index do |_pos, index|
      routes << [*0.. (free_moves.length - (index + 1))]
    end
    routes.first.product(*routes[1..-1])
  end

  def win_for_us?(game_state)
    game_state.won? && game_state.player == @game_state.player
  end

  def loss_for_us?(game_state)
    game_state.lost? && game_state.player == @game_state.player
  end

  def board
    game_state.current_state
  end
end
