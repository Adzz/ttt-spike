require 'pry'
require 'path'

class DirectedGraph
  def initialize(node)
    @node = node
    @paths = []
  end

  def weighted_paths
    routes.each do |route|
      path = [
        node.successors[route[0]]
      ]

      route[1..-1].each do |node_location|
        first_node = path.pop
        path.push(first_node)
        next_node = first_node.successors[node_location]

        if first_node.can_win?
          if first_node.player == node.player
            paths << Path.new(path, 100-path.length)
          else
            paths << Path.new(path, -(100-path.length))
          end
          break
        end

        path.push(next_node)
      end
      paths << Path.new(path, 0)
    end
    paths
  end

  private

  attr_reader :node, :paths

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
