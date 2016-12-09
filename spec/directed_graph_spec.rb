require 'spec_helper'
require 'directed_graph'
require 'node'
require 'pry'

RSpec.describe DirectedGraph do
  let(:node) { Node.new("X", [*0..8]) }

  xcontext '#add_edge' do
    it 'addes an edge from one node to another' do
      node = Node.new("X", [*0..3])
      expect(subject.add_edge(node, node.successors[0])).to match a_hash_including(node => node.successors.first)
    end
  end

  context '#add_node' do
    xit 'addes a node to the graph' do
      node = Node.new("X", [*0..3])
      expect { subject.add_node(node) }.to change { subject.nodes.count }.from(0).to(1)
    end
  end

  context 'creating paths' do
    it 'generate all possible paths for a given edge' do
      player = "X"
      board = [*0..3]
      expect(subject.get_possibilities(player, board)).to eq 1
    end
  end
end
