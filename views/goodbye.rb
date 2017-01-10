require_relative 'curses_wrapper.rb'

class Goodbye

  def initialize
    @curses = CursesWrapper::Screen.new
  end

  def screen
    curses.display do
      curses.refresh
      curses.position_and_type_from_center("Too Bad....")
      curses.get_char
    end
  end

  private

  attr_reader :curses
end
