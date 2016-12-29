class Invoker
  def initialize
    @history = []
  end

  def record_and_execute(log=true)
    @history << command if log
    command.execute
  end
end