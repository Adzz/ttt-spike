require 'node'

class DirectedGraph
  def initialize
    @nodes = {}
  end

  # def visit_nodes(nodes)
  #   nodes.each do |node|
  #     yield node
  #   end
  # end

  def add_node(node)
    return @nodes if (node.current_state - ["X"] - ["O"]).empty?
    @nodes[node.current_state] = node
    node.successors.each do |successor|
      add_node(successor)
    end
  end

  def [](state)
    @nodes[state]
  end
end
