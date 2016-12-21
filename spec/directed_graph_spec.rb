require 'spec_helper'
require 'directed_graph'
require 'node'
require 'pry'

RSpec.describe DirectedGraph do
  context 'generating a game tree' do
    it 'produces a game tree of all possible states for a given board' do
      node = Node.new("X", [*0..8])
      directed_graph = described_class.new(node)
      expect(directed_graph.weighted_paths.map(&:weight)).to eq [-1]
    end
  end

  it 'blah' do
    dg = described_class.new(Node.new("X", [*0..8]))
    expect(dg.weighted_paths).to eq 1
  end
end
