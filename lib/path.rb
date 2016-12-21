class Path
  def initialize(nodes, weight)
    @nodes = nodes
    @weight = weight
  end

  attr_reader :weight, :nodes
end
