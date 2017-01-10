require_relative 'curses_wrapper.rb'

class Welcome
  WELCOME_STRING = "Hello stranger, what is your name?".freeze
  PREFER = "Wouldn't you prefer a nice game of Tic Tac Toe...".freeze
  NICE = "How about a nice game of Tic Tac Toe...".freeze

  def initialize
    @curses = CursesWrapper::Screen.new
  end

  def screen
    curses.display do
      welcome_message
      get_name
      name = curses.user_response
      invite(name)
      answer = curses.user_response
      curses.refresh
      evaluate(answer)
    end
  end

  private

  attr_reader :curses

  def welcome_message
    curses.position_and_type_from_center(WELCOME_STRING,4)
  end

  def get_name
    curses.position_and_type_from_center("",2,4)
  end

  def invite(name)
    curses.clear
    curses.refresh
    curses.position_and_type_from_center("Welcome #{name}, shall we play a game?", 4)
    curses.position_and_type_from_center("")
  end

  def evaluate(answer)
    if answer.match(/.*(Global Thermonuclear War)|(Thermonuclear War).*/i)
      curses.position_and_type_from_center(PREFER ,-4)
      curses.get_char
      return true
    end
    unless answer.match(/.*(no)|(nope)|(nah).*/i)
      curses.position_and_type_from_center(NICE, -4)
      curses.get_char
      return true
    end
    false
  end
end
