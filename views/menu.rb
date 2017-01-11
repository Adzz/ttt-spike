require_relative '../lib/curses/screen.rb'
require_relative '../lib/curses/keyboard.rb'

class Menu
  extend Forwardable

  MENU_HEADING = "Choose Game Type".freeze
  ONE_PLAYER   = "1. Go Solo".freeze
  TWO_PLAYER   = "2. It's better with friends...".freeze
  ARROW        = "==> ".freeze

  def initialize
    @curses = CursesWrapper::Screen.new
    @keyboard = CursesWrapper::Keyboard.new
  end

  def screen
    display do
      silent_keys
      position_and_type_from_center(MENU_HEADING, 7)
      position_and_type_from_center(ONE_PLAYER, 2)
      position_and_type_from_center(TWO_PLAYER)
      one_player_game?
    end
  end

  private

  def_delegators :@curses,
    :display, :position_and_type_from_center, :get_command,
    :silent_keys, :char_under_cursor

  def_delegator :@keyboard, :keys

  def one_player_game?
    game_type == keys[:one]
  end

  def game_type
    response = get_command
    case response
    when keys[:up_arrow]
      position_and_type_from_center(ARROW, 2, x_offset(ONE_PLAYER, ARROW))
      game_type
    when keys[:down_arrow]
      position_and_type_from_center(ARROW, 0, x_offset(TWO_PLAYER, ARROW))
      game_type
    when ->(response) { keys[:return_key].include?(response) }
      return char_under_cursor
    else
      game_type
    end
  end

  def x_offset(text, arrow)
    -(text.length/2 + (arrow.length/2))
  end
end
