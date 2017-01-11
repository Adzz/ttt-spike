require_relative '../lib/curses/screen.rb'

class Goodbye
  extend Forwardable

  def initialize
    @curses = CursesWrapper::Screen.new
  end

  def screen
    display do
      refresh
      position_and_type_from_center("Too Bad....")
      sleep(2)
    end
  end

  private

  def_delegators :@curses, :display, :position_and_type_from_center, :refresh
end
