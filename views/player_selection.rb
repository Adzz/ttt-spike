require_relative '../lib/curses/screen.rb'

class PlayerSelection
  SELECTION = "Choose Your Character"

  def initialize
    @curses = CursesWrapper::Screen.new
  end

  def screen
    curses.display do
      curses.silent_keys
      display_options
      player
    end
  end

  private

  attr_reader :curses

  def player
    choose_selection == 79 ? "O" : "X"
  end

  def choose_selection
    response = getch
    if response == Curses::Key::LEFT
      position_and_type_from_center("", 0, -3)
      choose_selection
    elsif response == Curses::Key::RIGHT
      position_and_type_from_center("", 0, 1)
      choose_selection
    elsif return_key.include?(response)
      return inch()
    else
      choose_selection
    end
  end

  def display_options
    curses.bold_type do
      curses.position_and_type_from_center(SELECTION, 2)
      curses.position_and_type_from_center("X", 0, -2)
      curses.position_and_type_from_center("O", 0, 2)
      curses.position_and_type_from_center("", 0, -3)
    end
  end
end
