require 'curses'

module CursesWrapper
  class Keyboard
    include Curses

    def keys
      {
        "1": ?1.ord,
        up_arrow: Curses::Key::UP,
        down_arrow: Curses::Key::DOWN,
        left_arrow: Curses::Key::LEFT,
        right_arrow: Curses::Key::RIGHT,
        X: ?X.ord,
        x: ?x,
        q: ?q,
        o: ?o,
        d: ?d,
        r: ?r,
        O: ?O.ord,
        return_key: [Curses::KEY_ENTER, 10, 13]
      }
    end
  end
end
