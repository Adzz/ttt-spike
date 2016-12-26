require_relative 'window.rb'
# wrap the curses methods in better more ruby-esque method names?
# command pattern for entering commands?
class Menu < Window
  MENU_HEADING = "Choose Game Type".freeze
  ONE_PLAYER   = "1. Go Solo".freeze
  TWO_PLAYER   = "2. It's better with friends...".freeze
  ARROW        = "==> ".freeze

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
        position_and_type_from_center(MENU_HEADING, 7)
      end
      position_and_type_from_center(ONE_PLAYER, 2)
      position_and_type_from_center(TWO_PLAYER)
      one_player_game?
    ensure
      window.close
    end
  end

  private

  def one_player_game?
    game_type == 49
  end

  def game_type
    response = getch
    if response == Curses::Key::UP
      position_and_type_from_center(ARROW, 2, x_offset(ONE_PLAYER, ARROW))
      game_type
    elsif response == Curses::Key::DOWN
      position_and_type_from_center(ARROW, 0, x_offset(TWO_PLAYER, ARROW))
      game_type
    elsif return_key.include?(response)
      return inch()
    else
      game_type
    end
  end

  def x_offset(text, arrow)
    -(text.length/2 + (arrow.length/2))
  end
end
