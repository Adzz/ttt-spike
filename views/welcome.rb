require_relative 'window.rb'

class Welcome < Window
  WELCOME_STRING = "Hello stranger, what is your name?"

  def screen
    window.refresh
    welcome_message
    get_name
    name = user_response
    invite(name)
    answer = user_response
    evaluate(answer)
  end

  private

  def welcome_message
    position_and_type_from_center(WELCOME_STRING,4)
  end

  def get_name
    position_and_type_from_center('',2,4)
  end

  def invite(name)
    window.clear
    window.refresh
    position_and_type_from_center("Welcome #{name}, shall we play a game?", 4)
    position_and_type_from_center("")
  end

  def evaluate(answer)
    if answer.match(/.*(Global Thermonuclear War)|(Thermonuclear War).*/i)
      position_and_type_from_center("Wouldn't you prefer a nice game of Tic Tac Toe...",-4)
      getch
      return true
    elsif !answer.match(/(no)|(nope)|(nah)/i)
      position_and_type_from_center("How about a nice game of Tic Tac Toe...", -4)
      getch
      return true
    end
    false
  end
end
