class DirectedGraph
  PATH = Struct.new(:nodes, :weight) do
    def initialize(*)
        super
        self.nodes ||= []
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

      # generated_path(nodes, PATH.new, route)
#       route.drop(1).each do |node_location|
#         first_node = nodes.pop
#         nodes.push(first_node)
# #  could we just check for a game_over, THEN pass that board to be evaluated
# # and assign a weight based on it's evaluation.
#         if first_node.game_over?
#           binding.pry
#           path.nodes= nodes
#           break
#         end

#         next_node = first_node.successors[node_location]
#         nodes.push(next_node)

        # if first_node.lost? # check if we win after our first move
        #   path.weight= (100 - nodes.length)
        #   break
        # elsif first_node.won? # check if we lost after our first move
        #   path.weight= (- (100 - nodes.length)) 
        #   break
        # elsif next_node.lost? # check if they lost after their first move
        #   if first_node.player == node.player 
        #     path.weight= (100 - nodes.length) 
        #   else
        #     path.weight= (- (100 - nodes.length))
        #   end
        #   break
        # else
        #   nodes.push(next_node)
        # end
      # end

      # path.nodes= nodes
      paths << evaluate(generated_path(nodes, PATH.new, route))
    end
  end

  def generated_path(nodes, path, route, iterator=1)
    first_node = nodes.pop
    nodes.push(first_node)
    path.nodes= nodes; return path if first_node.game_over?
    next_node = first_node.successors[route[iterator]]
    nodes.push(next_node)
    generated_path(nodes, path, route, iterator+=1)
  end

  def evaluate(path)
    final_state = path.nodes.last
    path.weight= (100 - path.nodes.length) if win_for_us?(final_state)
    path.weight= (- (100 - path.nodes.length)) if loss_for_us?(final_state)
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

  def win_for_us?(node)
    node.won? && node.player == @node.player
  end

  def loss_for_us?(node)
    node.lost? && node.player == @node.player
  end

  def board
    node.current_state
  end
end
