class DirectedGraph
  def initialize
    @nodes = []
    @edges = tree
    @paths = []
  end

  attr_reader :nodes, :edges, :paths

  def add_edge(from, to)
    edges[from] = to
  end

  def get_possibilities(node)
    index_combinations.each do |index_combo|
      first_wave   = node.successors[index_combo[0]]
      second_wave  = first_wave.successors[index_combo[1]]
      third_wave   = second_wave.successors[index_combo[2]]
      fourth_wave  = third_wave.successors[index_combo[3]]
      fifth_wave   = fourth_wave.successors[index_combo[4]]
      sixth_wave   = fifth_wave.successors[index_combo[5]]
      seventh_wave = sixth_wave.successors[index_combo[6]]
      eigth_wave   = seventh_wave.successors[index_combo[7]]
      ninth_wave   = eigth_wave.successors[index_combo[8]]

      paths << [node.current_state, first_wave.current_state, second_wave.current_state, third_wave.current_state, fourth_wave.current_state, fifth_wave.current_state, sixth_wave.current_state, seventh_wave.current_state, eigth_wave.current_state, ninth_wave.current_state]
      # paths[node.current_state][first_wave.current_state][second_wave.current_state][third_wave.current_state][fourth_wave.current_state][fifth_wave.current_state][sixth_wave.current_state][seventh_wave.current_state][eigth_wave.current_state] = ninth_wave.current_state
    end
    paths
    # node.current_state.each_with_index.with_object([]) do |(value, index), object|
    #   next unless value.is_a? Numeric
    #   possible_next_move = node.current_state.dup
    #   possible_next_move[index] = node.player

    #   possibility = Node.new(other_player(node.player), possible_next_move)
    #   add_edge(node.current_state, possibility.current_state)

    #   get_possibilities(possibility)
    # end
  end

  def index_combinations
    board = [*0..8]
    index_combinations = []
    board.each_with_index do |_pos, index|
      index_combinations << [*0.. (board.length - (index + 1))]
    end
    index_combinations.first.product(*index_combinations[1..-1])
  end

 # paths[board] = add_edge(Node.new(player, board), Node.new(other_player(player), possible_next_move))

  def add_node(node)
    nodes << node.current_state
    node.successors.each_with_index do |successor|
      successor.successors
    end
  end



  def other_player(player)
    player == "O" ? "X" : "O"
  end

  def tree
    Hash.new do |hash, key|
      hash[key] = tree
    end
  end
end
