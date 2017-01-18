require_relative '../lib/curses/screen.rb'
require_relative '../lib/curses/keyboard.rb'

class PlayerSelection
  extend Forwardable

  SELECTION  = 'Choose Your Character'.freeze
  ONE_PLAYER = 'X (Goes first)'.freeze
  TWO_PLAYER = 'O (Waits patiently)'.freeze
  ARROW      = "==> ".freeze

  def initialize
    @curses = CursesWrapper::Screen.new
    @keyboard = CursesWrapper::Keyboard.new
  end

  def screen
    display do
      silent_keys
      position_and_type_from_center(SELECTION, 7)
      position_and_type_from_center(ONE_PLAYER, 2)
      position_and_type_from_center(TWO_PLAYER)
      player
    end
  end

  private

  def_delegators :@curses,
    :display, :position_and_type_from_center, :get_command,
    :silent_keys, :char_under_cursor

  def_delegator :@keyboard, :keys

  def player
    choose_player == keys[:O] ? 'O' : 'X'
  end

  def choose_player
    response = get_command
    case response
    when keys[:up_arrow]
      position_and_type_from_center(ARROW, 2, x_offset(ONE_PLAYER, ARROW))
      choose_player
    when keys[:down_arrow]
      position_and_type_from_center(ARROW, 0, x_offset(TWO_PLAYER, ARROW))
      choose_player
    when ->(response) { keys[:return_key].include?(response) }
      return char_under_cursor
    else
      choose_player
    end
  end

  def x_offset(text, arrow)
    -(text.length/2 + (arrow.length/2))
  end
end
