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
    binding.pry
    nodes[node.current_state] = node
    node.successors.each do |successor|
     nodes[successor.current_state] = successor
    end
  end

  attr_reader :nodes
end
