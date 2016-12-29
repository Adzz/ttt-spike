require_relative 'window.rb'

class PlayerSelection < Window
  SELECTION = "Choose Your Character"
  
  def screen
    begin
      window.refresh
      noecho
      display_options
      player
    ensure
      window.close
    end
  end

  private

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
    attron(color_pair(COLOR_BLUE)|A_BOLD) do
      position_and_type_from_center(SELECTION, 2)
      position_and_type_from_center("X", 0, -2)
      position_and_type_from_center("O", 0, 2)
      position_and_type_from_center("", 0, -3)
    end
  end
end
