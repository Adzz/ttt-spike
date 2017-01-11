require_relative '../lib/curses/screen.rb'
require_relative '../lib/curses/keyboard.rb'

class Selection
  extend Forwardable

  def initialize(choices)
    @curses = CursesWrapper::Screen.new
    @keyboard = CursesWrapper::Keyboard.new
    @choices = choices
  end

    def screen
    display do
      silent_keys
      position_and_type_from_center(choices[0], 7)
      position_and_type_from_center(choices[1], 2)
      position_and_type_from_center(choices[2])
      selection
    end
  end

  private

  attr_reader :choices

  def_delegators :@curses,
    :display, :position_and_type_from_center, :get_command,
    :silent_keys, :char_under_cursor

  def_delegator :@keyboard, :keys, :translated

  def selection
    response = get_command
    case response
    when keys[:up_arrow]
      position_and_type_from_center(arrow, 2, x_offset(choices[1], arrow))
      selection
    when keys[:down_arrow]
      position_and_type_from_center(arrow, 0, x_offset(choices[2], arrow))
      selection
    when ->(response) { keys[:return_key].include?(response) }
      return translated(char_under_cursor)
    else
      selection
    end
  end

  def arrow
    '==> '
  end

  def x_offset(text, arrow)
    -(text.length/2 + (arrow.length/2))
  end
end
