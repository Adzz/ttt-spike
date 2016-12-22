require_relative 'window.rb'

class Game < Window
  include Curses

  def screen
    getch
  end
end
