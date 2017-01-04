class DirectedGraph
  PATH = Struct.new(:nodes, :weight) do
    def initialize(*)
        super
        self.weight ||= 0
    end
  end

  def initialize(node)
    @node = node
  end

  def choose_move
    return ["X",1,2,3,4,5,6,7,8] if node.current_state == [*0..8]

    grouped_paths.max_by do |_key, value|
      value.map(&:weight).inject(&:+)
    end.first
  end

  private

  attr_reader :node

  def grouped_paths
    weighted_paths.group_by do |path|
      path.nodes.first.current_state
    end
  end

  def weighted_paths
    routes.each_with_object([]) do |route, paths|

      nodes = [
        node.successors[route.first]
      ]

      route.drop(1).each do |node_location|
        first_node = nodes.pop
        nodes.push(first_node)
        next_node = first_node.successors[node_location]

        if first_node.lost?
          if first_node.player == node.player
            paths << PATH.new(nodes, -(100 - nodes.length))
          else
            paths << PATH.new(nodes, 100 - nodes.length)
          end
          break
        elsif first_node.won? || next_node.lost?
          if first_node.player == node.player
            paths << PATH.new(nodes, 100 - nodes.length)
          else
            paths << PATH.new(nodes, - (100 - nodes.length))
          end
          break
        else
          nodes.push(next_node)
        end
      end
      
      paths << PATH.new(nodes)
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
    node.current_state
  end
end
