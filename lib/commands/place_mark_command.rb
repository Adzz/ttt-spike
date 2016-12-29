class PlaceMarkCommand
  def initialize(screen)
    @screen = screen
  end

  def execute
    screen.place_mark
  end
end
