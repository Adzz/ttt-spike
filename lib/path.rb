class Path
  include Comparable

  def initialize(nodes, weight)
    @nodes = nodes
    @weight = weight
  end

  def <=>(other)
    weight <=> other.weight
  end

  attr_reader :weight, :nodes
end
