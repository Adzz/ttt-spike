class DirectedGraph
  def initialize
    @nodes = []
    @edges = tree
    @paths = tree
  end

  attr_reader :nodes, :edges, :paths

  def add_node(node)
    nodes << node
  end

  def add_edge(from, to)
    edges[from] = to
    edges
  end

  def get_possibilities(player, board)
    board.each_with_index.with_object([]) do |(value, index), object|
      next unless value.is_a? Numeric
      possible_next_move = board.dup
      possible_next_move[index] = player
      possibility = Node.new(other_player(player), possible_next_move)
      add_edge(Node.new(player, board), possibility)
      get_possibilities(possibility.player, possibility.current_state)
    end
    binding.pry
  end


 # paths[board] = add_edge(Node.new(player, board), Node.new(other_player(player), possible_next_move))


  #   def add_node(node)
  #   return nodes if (node.current_state - ["X"] - ["O"]).empty?
  #   node.successors.each do |successor|
  #     add_edge(node, successor)
  #   end
  #   binding.pry
  #   nodes
  # end

  def other_player(player)
    player == "O" ? "X" : "O"
  end

  def tree
    Hash.new do |hash, key|
      hash[key] = tree
    end
  end
end


module YCombinator
    def y_comb(&generator)
        proc { |x|
            proc { |*args|
                generator.call(x.call(x)).call(*args)
            }
        }.call(proc { |x|
            proc { |*args|
                generator.call(x.call(x)).call(*args)
            }
        })
    end
end

