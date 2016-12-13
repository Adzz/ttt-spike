class DirectedGraph
  def initialize(node)
    @node = node
    @game_tree = tree
  end

  attr_reader :game_tree

  def possibilities
    index_combinations.each_with_index do |index_combo|
      first_wave   = node.successors[index_combo[0]]
      second_wave  = first_wave.successors[index_combo[1]]
      third_wave   = second_wave.successors[index_combo[2]]
      fourth_wave  = third_wave.successors[index_combo[3]]
      fifth_wave   = fourth_wave.successors[index_combo[4]]
      sixth_wave   = fifth_wave.successors[index_combo[5]]
      seventh_wave = sixth_wave.successors[index_combo[6]]
      eigth_wave   = seventh_wave.successors[index_combo[7]]
      ninth_wave   = eigth_wave.successors[index_combo[8]]

      if game_tree.empty?
        game_tree[board][first_wave.current_state][second_wave.current_state][third_wave.current_state][fourth_wave.current_state][fifth_wave.current_state][sixth_wave.current_state][seventh_wave.current_state][eigth_wave.current_state] = ninth_wave.current_state
      else
        path = tree

        path[board][first_wave.current_state][second_wave.current_state][third_wave.current_state][fourth_wave.current_state][fifth_wave.current_state][sixth_wave.current_state][seventh_wave.current_state][eigth_wave.current_state] = ninth_wave.current_state

        deep_merge!(game_tree, path)
      end
    end
    game_tree
  end

  private

  attr_reader :node

  def board
    node.current_state
  end

  def deep_merge!(into_this_hash, this_hash)
    into_this_hash.merge!(this_hash) do |key, first_hash_value, second_hash_value|
      deep_merge!(first_hash_value, second_hash_value)
    end
  end

  def index_combinations
    index_combinations = []
    board.each_with_index do |_pos, index|
      index_combinations << [*0.. (board.length - (index + 1))]
    end
    index_combinations.first.product(*index_combinations[1..-1])
  end

  def tree
    Hash.new do |hash, key|
      hash[key] = tree
    end
  end
end
