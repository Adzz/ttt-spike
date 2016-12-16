require 'pry'

class DirectedGraph
  def initialize(node)
    @node = node
    @game_tree = tree
    possibilities
  end

  attr_reader :game_tree

  private

  def possibilities
    [routes[0]].each do |node_locations|
# generate a path: 
      path = [
        node.successors[node_locations[0]]
      ]

      node_locations.drop(1).each do |index|
        node = path.pop
        next_node = node.successors[node_locations[index]]
        path.push(node, next_node)
      end

#  evaluate path:
      path.each_with_index.map do |state, index|
        path = path[0..index] if state.losing? || state.winning?
        
      end

binding.pry

      # if game_tree.empty?
      #   game_tree[board][first_wave.current_state][second_wave.current_state][third_wave.current_state][fourth_wave.current_state][fifth_wave.current_state][sixth_wave.current_state][seventh_wave.current_state][eigth_wave.current_state] = ninth_wave.current_state
      # else
      #   path = tree

      #   path[board][first_wave.current_state][second_wave.current_state][third_wave.current_state][fourth_wave.current_state][fifth_wave.current_state][sixth_wave.current_state][seventh_wave.current_state][eigth_wave.current_state] = ninth_wave.current_state

      #   deep_merge!(game_tree, path)
      # end
    end
    # game_tree
  end

  attr_reader :node

  def board
    node.current_state
  end

  def deep_merge!(into_this_hash, this_hash)
    into_this_hash.merge!(this_hash) do |key, first_hash_value, second_hash_value|
      deep_merge!(first_hash_value, second_hash_value)
    end
  end

  def routes
    routes = []
    board.each_with_index do |_pos, index|
      routes << [*0.. (board.length - (index + 1))]
    end
    routes.first.product(*routes[1..-1])
  end

  def tree
    Hash.new do |hash, key|
      hash[key] = tree
    end
  end
end
