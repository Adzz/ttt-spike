require 'pry'
require 'path'

class DirectedGraph
  def initialize(node)
    @node = node
  end

  def choose_move
    return ["X",1,2,3,4,5,6,7,8] if node.current_state == [*0..8]
    weighted_paths.sort.last.nodes.first.current_state
  end

  def weighted_paths
    routes.each_with_object([]) do |route, paths|

      path = [
        node.successors[route[0]]
      ]
      
      path_weight = 10 

      route.drop(1).each do |node_location|
        first_node = path.pop
        path.push(first_node)
        next_node = first_node.successors[node_location]

        if first_node.can_win?
          if first_node.player == node.player
            path_weight = 100 - path.length
          else
            path_weight = - (100 - path.length)
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
end
