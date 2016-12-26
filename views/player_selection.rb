require_relative 'window.rb'

class PlayerSelection < Window

  def screen
    begin
      window.refresh
      noecho
      display_selections
      player
    ensure
      window.close
    end
  end

  private

  def player
    choose_selection == 116 ? "O" : "X"
  end

  def choose_selection
    response = getch
    if response == Curses::Key::LEFT
      position_and_type_from_center("", 0, -2)
      choose_selection
    elsif response == Curses::Key::RIGHT
      position_and_type_from_center("", 0, 2)
      choose_selection
    elsif return_key.include?(response)
      return inch()
    else
      choose_selection
    end
  end

  def display_selections
    attron(color_pair(COLOR_BLUE)|A_BOLD) do
      position_and_type_from_center("X", 0, -2)
      position_and_type_from_center("O", 0, 2)
    end
  end
end
