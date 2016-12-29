require_relative 'path'

class DirectedGraph
  def initialize(node)
    @node = node
  end

  def choose_move
    return ["X",1,2,3,4,5,6,7,8] if node.current_state == [*0..8]
    max_score
  end

  def weighted_paths
    routes.each_with_object([]) do |route, paths|

      path = [
        node.successors[route[0]]
      ]

      path_weight = 0 

      route.drop(1).each do |node_location|
        first_node = path.pop
        path.push(first_node)
        next_node = first_node.successors[node_location]

        if first_node.won? || next_node.lost?
          if first_node.player == node.player
            path_weight = 100 - path.length
          else
            path_weight = - (100 - path.length)
          end
          break
        elsif first_node.lost? || next_node.won?
          if first_node.player == node.player
            path_weight = - (100 - path.length)
          else
            path_weight = 100 - path.length
          end
          break
        else
          path.push(next_node)
        end
      end
      paths << Path.new(path, path_weight)
    end
  end

  private

  attr_reader :node

  def max_score
    grouped_paths.max_by do |_key, value|
      value.map(&:weight).inject(&:+)
    end.first
  end

  def board
    node.current_state
  end

  def routes
    routes = []
    free_moves = (board - ["X"] - ["O"])
    free_moves.each_with_index do |_pos, index|
      routes << [*0.. (free_moves.length - (index + 1))]
    end
    routes.first.product(*routes[1..-1])
  end

  def grouped_paths
    weighted_paths.group_by do |path|
      path.nodes.first.current_state
    end
  end
end
