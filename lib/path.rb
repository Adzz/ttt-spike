class Path
  def initialize(nodes, weight=0)
    @nodes = nodes
    @weight = weight
  end

  attr_reader :nodes, :weight
end
