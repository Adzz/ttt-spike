RSpec.describe CursesWrapper::Screen do
  let!(:curses) { double Curses }
  subject { described_class.new(curses) }

  describe "#silent_keys" do
    it "calls noecho" do
      expect(curses).to receive(:noecho).once
      subject.silent_keys
    end
  end

  describe "#clear" do
    it "calls clear" do
      expect(curses.stdscr).to receive(:clear).once
      subject.clear
    end
  end

  describe "#delete_char_under_cursor" do
    it "calls delch" do
      expect(curses).to receive(:delch).once
      subject.delete_char_under_cursor
    end
  end

  describe "#char_under_cursor" do
    it "calls inch" do
      expect(curses).to receive(:inch).once
      subject.char_under_cursor
    end
  end

  describe "#get_command" do
    it "calls getch" do
      expect(curses).to receive(:getch).once
      subject.get_command
    end
  end

  describe "#screen_rows" do
    it "calls lines" do
      expect(curses).to receive(:lines).once
      subject.screen_rows
    end
  end

  describe "#screen_columns" do
    it "calls cols" do
      expect(curses).to receive(:cols).once
      subject.screen_columns
    end
  end

  describe "#insert_char_before_cursor" do
    it "calls insch" do
      expect(curses).to receive(:insch).once
      subject.insert_char_before_cursor("X")
    end
  end

  describe "#move_cursor_to" do
    it "calls setpos" do
      expect(curses).to receive(:setpos).with(1, 3).once
      subject.move_cursor_to(1, 3)
    end
  end

  describe "#add_string" do
    it "calls addstr" do
      expect(curses).to receive(:addstr).with("aww yis").once
      subject.add_string("aww yis")
    end
  end

  describe "#enable_keyboard" do
    it "calls raw" do
      expect(curses).to receive(:raw).once
      subject.enable_keyboard
    end
  end

  describe "#enable_enter_key" do
    it "calls nonl" do
      expect(curses).to receive(:nonl).once
      subject.enable_enter_key
    end
  end

  describe "#screen" do
    it "calls stdscr" do
      expect(curses).to receive(:stdscr).once
      subject.screen
    end
  end

  describe "#init_screen" do
    it "calls init_screen" do
      expect(curses).to receive(:init_screen).once
      subject.init_screen
    end
  end

  describe "#enable_function_keys" do
    it "calls keypad" do
      expect(curses.stdscr).to receive(:keypad).with(true).once
      subject.enable_function_keys
    end
  end

  describe "#quit_cleanly" do
    it "calls clear" do
      expect(curses.stdscr).to receive(:clear).once
      subject.quit_cleanly
    end

    it "calls screen close" do
      expect(curses).to receive(:close_screen).once
      subject.quit_cleanly
    end
  end

  describe "#get_string" do
    it "calls getstr" do
      expect(curses).to receive(:getstr).once
      subject.get_string
    end
  end

  describe "#type" do
    it "adds a string one char at a time" do
      string = "aww yis"
      expect(curses).to receive(:addstr).exactly(string.length).times
      subject.type(string)
    end

    it 'refreshes between each char, to appear typed' do
      string = "aww yis"
      expect(curses).to receive(:doupdate).exactly(string.length).times
      subject.type(string)
    end
  end

  describe "#refresh" do
    it "calls doupdate" do
      expect(curses).to receive(:doupdate).once
      subject.refresh
    end
  end

  describe "#border" do
    it "calls box on stdscr" do
      expect(curses.stdscr).to receive(:box).with("|", "-").once
      subject.border("|", "-")
    end
  end


  describe "#display" do
    describe "config" do
      specify { expect { |bloc| subject.display(&bloc) }.to yield_with_no_args }

      it "enables  the enter_key" do
        expect(curses).to receive(:nonl).once
        subject.display { subject.silent_keys }
      end

      it "enables function keys" do
        expect(curses.stdscr).to receive(:keypad).with(true).once
        subject.display { subject.silent_keys }
      end

      it "enables the standard keyboard" do
        expect(curses).to receive(:raw).once
        subject.display { subject.silent_keys }
      end

      it "initializes a standard screen" do
        expect(curses).to receive(:init_screen).once
        subject.display { subject.silent_keys }
      end

      it "ensure clear is called" do
        expect(curses.stdscr).to receive(:clear).once
        subject.display { subject.silent_keys }
      end

      it "ensures close_screen is called" do
        expect(curses).to receive(:close_screen).once
        subject.display { subject.silent_keys }
      end
    end
  end

  describe "#y_midpoint" do
    it "returns the midpoint of the y axis for the screen" do
      rows = subject.screen_rows
      expect(subject.y_midpoint).to eq rows / 2
    end
  end

  describe "#x_midpoint" do
    it "returns the midpoint of the x axis for the screen" do
      columns = subject.screen_columns
      expect(subject.x_midpoint).to eq columns / 2
    end
  end

  describe "#position_and_type_from_center" do
    it "types to the screen" do
      string = "aww yis"
      expect(subject).to receive(:type).with(string, anything).once
      subject.position_and_type_from_center(string)
    end
  end
end
