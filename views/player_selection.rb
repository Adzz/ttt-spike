require_relative './selection.rb'

class PlayerSelection
  MENU_HEADING  = 'Choose Your Character'.freeze
  ONE_PLAYER = 'X (Goes first)'.freeze
  TWO_PLAYER = 'O (Waits patiently)'.freeze

  def initialize
    @selection = Selection.new([MENU_HEADING, ONE_PLAYER, TWO_PLAYER])
  end

  def screen
    @selection.screen == CursesWrapper::Keyboard.new.keys[:X] ? "X" : "O"
  end
end