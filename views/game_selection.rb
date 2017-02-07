require_relative './selection.rb'

class GameSelection
  MENU_HEADING = "Choose Game Type".freeze
  ONE_PLAYER   = "1. Go Solo".freeze
  TWO_PLAYER   = "2. It's better with friends...".freeze

  def initialize
    @selection = Selection.new([MENU_HEADING, ONE_PLAYER, TWO_PLAYER])
  end

  def screen
    @selection.screen == CursesWrapper::Keyboard.new.keys[:"1"] ? true : false
  end
end
