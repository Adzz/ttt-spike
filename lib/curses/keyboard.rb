require 'curses'

module CursesWrapper
  class Keyboard
    include Curses

    def keys
      {
        one: ?1.ord,
        up_arrow: Curses::Key::UP,
        down_arrow: Curses::Key::DOWN,
        left_arrow: Curses::Key::LEFT,
        right_arrow: Curses::Key::RIGHT,
        x: ?x.ord,
        q: ?q.ord,
        o: ?o.ord,
        d: ?d.ord,
        r: ?r.ord,
        O: ?O.ord,
        return_key: [Curses::KEY_ENTER, 10, 13]
      }
    end
  end
end
