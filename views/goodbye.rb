require_relative 'window.rb'

class Goodbye < Window

  def screen
    begin
      window.refresh
      position_and_type_from_center("Too Bad....")
      window.getch
      close_screen
    ensure
      window.close
    end
  end

  private

  attr_reader :window
end