class AI
  def next_move(board)
    return ["X",1,2,3,4,5,6,7,8] unless board.include?(player)
  end

  def player
    raise NotImplementedError
  end
end

class AI_X < AI
  def player
    "X"
  end
end

class AI_O < AI
  def player
    "O"
  end
end


# class Node
#   attr_reader :successors, :state
#   def initialize(state)
#     @state = state
#     @successors = []
#   end

#   def visit_all_children
#     successors.each { |successor|
#        yield successor
#     }
#   end

#   def add_edge(node)
#     successors << node
#     Edge.new(self, node)
#   end

#   def out_degree
#     successor.count
#   end
# end




