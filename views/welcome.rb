require_relative '../lib/curses/screen.rb'

class Welcome
  extend Forwardable

  WELCOME_STRING = "Hello stranger, what is your name?".freeze
  PREFER = "Wouldn't you prefer a nice game of Tic Tac Toe...".freeze
  NICE = "How about a nice game of Tic Tac Toe...".freeze

  def initialize
    @curses = CursesWrapper::Screen.new
  end

  def screen
    display do
      welcome_message
      get_name
      name = user_response
      invite(name)
      answer = user_response
      refresh
      evaluate(answer)
    end
  end

  private

  def_delegators :@curses,
    :display, :position_and_type_from_center, :refresh, :clear, :get_command, :user_response

  def welcome_message
    position_and_type_from_center(WELCOME_STRING,4)
  end

  def get_name
    position_and_type_from_center("",2,4)
  end

  def invite(name)
    clear
    refresh
    position_and_type_from_center("Welcome #{name}, shall we play a game?", 4)
    position_and_type_from_center("")
  end

  def evaluate(answer)
    if answer.match(/.*(Global Thermonuclear War)|(Thermonuclear War).*/i)
      position_and_type_from_center(PREFER ,-4)
      get_command
      return true
    end
    unless answer.match(/.*(no)|(nope)|(nah).*/i)
      position_and_type_from_center(NICE, -4)
      get_command
      return true
    end
    false
  end
end
