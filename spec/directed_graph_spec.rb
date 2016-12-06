require 'spec_helper'
require 'directed_graph'
require 'node'
require 'pry'

RSpec.describe DirectedGraph do
  describe '#add_node' do
    let(:node) { Node.new("X",[0]) }

    it 'adds a node to the graph' do
      expect(subject.add_node(node)).to match a_hash_including(
        node.current_state => node
      )
    end
  end

  describe '#generate_graph' do
    let(:node) { Node.new("X",[0]) }

    it 'adds a node to the graph' do
      binding.pry
      expect(subject.add_node(node)).to match a_hash_including(
        node.current_state => node
      )
    end
  end
end

