require_relative 'window.rb'

class Menu < Window
  MENU_HEADING = "Choose Game Type"
  ONE_PLAYER   = "Go Solo"
  TWO_PLAYER   = "It's better with friends..."

  def initialize
    super
    @position_x = cols / 2
    @position_y = lines / 2
  end

  def screen
    begin
      window.refresh
      noecho
      attron(color_pair(COLOR_BLUE)|A_BOLD) do
        position_and_type_from_center(MENU_HEADING,7)
      end
      position_and_type_from_center(ONE_PLAYER,2)
      position_and_type_from_center(TWO_PLAYER)
      
      # while true
      #   choice = getch
      #   case choice
      #   when Curses::Key::UP
      #     position_and_type_from_center("==>", 2, - ONE_PLAYER.length + 1)
      #   when Curses::Key::DOWN
      #     position_and_type_from_center("==>", 0, - TWO_PLAYER.length + 9)
      #   when ?q
      #     break
      #   end
      # end
    ensure
      window.close
    end
  end

  def get_response
    response = getch
    if response == Curses::Key::DOWN
      position_and_type_from_center("==>", 0, - TWO_PLAYER.length + 9)
      get_response
    elsif response == Curses::Key::UP
      position_and_type_from_center("==>", 2, - ONE_PLAYER.length + 1)
      get_response
    elsif response == Curses::Key::ENTER
      return true
    end
  end
end