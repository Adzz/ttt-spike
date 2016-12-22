require_relative 'window.rb'

class Goodbye < Window

  def screen
    window.refresh
    position_and_type_from_center("Too Bad....")
    window.getch
    close_screen
  end

  private

  attr_reader :window
end