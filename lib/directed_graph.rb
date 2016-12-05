class DirectedGraph
  def visit_nodes(nodes)
    nodes.each do |node|
      yield node
    end
  end

  def add_node(node, nodes={})
    nodes[node.current_state] = node
    #node.successors.each do |successor|
    #  nodes[successor.current_state] = successor
    #end
    nodes
  end
end

