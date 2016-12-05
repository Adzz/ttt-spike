require 'spec_helper'
require 'directed_graph'
require 'node'

RSpec.describe DirectedGraph do
  describe '#add_node' do
    let(:node) { Node.new("X",[0]) }

    it 'adds a node to the graph' do
      expect(subject.add_node(node)).to match a_hash_including(
        node.current_state => node
      )
    end
  end
end

