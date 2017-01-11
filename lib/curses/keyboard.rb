require 'curses'

module CursesWrapper
  class Keyboard
    include Curses

    def key(key_name)
      case key_name
      when :one then 49
      when :up_arrow then Curses::Key::UP
      when :down_arrow then Curses::Key::DOWN
      when :left_arrow then Curses::Key::LEFT
      when :right_arrow then Curses::Key::RIGHT
      when :x then ?x
      when :q then ?q
      when :o then ?o
      when :d then ?d
      end
    end
  end
end
