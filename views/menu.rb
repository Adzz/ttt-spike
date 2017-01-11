require_relative 'curses_wrapper.rb'

class Menu
  MENU_HEADING = "Choose Game Type".freeze
  ONE_PLAYER   = "1. Go Solo".freeze
  TWO_PLAYER   = "2. It's better with friends...".freeze
  ARROW        = "==> ".freeze

  def initialize
    @curses = CursesWrapper::Screen.new
  end

  def screen
    curses.display do
      curses.silent_keys
      curses.refresh
      curses.bold_type(curses.position_and_type_from_center(MENU_HEADING, 7))
      curses.position_and_type_from_center(ONE_PLAYER, 2)
      curses.position_and_type_from_center(TWO_PLAYER)
      one_player_game?
    end
  end

  private

  attr_reader :curses

  def one_player_game?
    game_type == curses.class::ONE  #49 # this should not be a magic number
  end

  def game_type
    response = curses.get_char
    case response
    when Curses::Key::UP
      curses.position_and_type_from_center(ARROW, 2, x_offset(ONE_PLAYER, ARROW))
      game_type
    when Curses::Key::DOWN
      curses.position_and_type_from_center(ARROW, 0, x_offset(TWO_PLAYER, ARROW))
      game_type
    when ->(response) { curses.return_key.include?(response) }
      return curses.char_under_cursor
    else
      game_type
    end
  end

  def x_offset(text, arrow)
    -(text.length/2 + (arrow.length/2))
  end
end
