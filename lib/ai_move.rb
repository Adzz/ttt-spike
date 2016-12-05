class AIMove
  def correct_move(board)
    Move.given(board)
  end
end

# [
#   "X",1,2,
#   3,4,5,
#   6,7,8
# ]

# [
#   "X",1,2,
#   3,4,5,
#   6,7,8
# ]
# 1st round going first - corner
# 1st round going second - middle

# 2nd Round going first

 # MOVES could be a yaml file we read in and lookup board, it returns the optimal position given the board layout.

class Node
  attr_reader :successors, :state
  def initialize(state)
    @state = state
    @successors = []
  end

  def visit_all_children
    successors.each { |successor|
       yield successor
    }
  end

  def add_edge(node)
    successors << node
    Edge.new(self, node)
  end

  def out_degree
    successor.count
  end
end
#  why have both. Edges are all that matter, and they are better named as nodes. All we need is to know the thing exists, and what other things it points to.
class Edge
  def initialize(tail_node, head_node)
    @tail_node = tail_node
    @head_node = head_node
    @weight
  end

  attr_accessor :weight
  attr_reader :tail_node, :head_node
end

# The in-degree   of a node is the number of edges incident on that node. IE, how many nodes is it a child of? Can only be known from the graph level?

# Path == a non empty series of nodes, that are connected



# Depth first search. Terminate the search as soon as we can 
# assign a score, I.E, we know the route will draw, win or lose. 
# As soon as a path's score dips below a previously calculated 
# score, (the besta? lowest current path score) terminate further calculation, and go to the next top node to keep the DFS.
# Also is it possible that as soon as we hit 10, don't calculate anymore moves? If one route gets a win in one go, weigh it higher than the one that gets a win in two goes, the latter is less likely to happen. 


# we need to sum the values of a bunch of paths. The path which leads to more winning paths is favoured.







