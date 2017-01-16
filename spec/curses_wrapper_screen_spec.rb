RSpec.describe CursesWrapper::Screen do
  describe "#silent_keys" do
    it "calls noecho" do
      expect(Curses).to receive(:noecho).once
      subject.silent_keys
    end
  end

  describe "#clear" do
    it "calls clear" do
      expect(Curses).to receive(:clear).once
      subject.clear
    end
  end

  describe "#delete_char_under_cursor" do
    it "calls delch" do
      expect(Curses).to receive(:delch).once
      subject.delete_char_under_cursor
    end
  end

  describe "#char_under_cursor" do
    it "calls inch" do
      expect(Curses).to receive(:inch).once
      subject.char_under_cursor
    end
  end

  describe "#get_command" do
    it "calls getch" do
      expect(Curses).to receive(:getch).once
      subject.get_command
    end
  end

  describe "#screen_rows" do
    it "calls lines" do
      expect(Curses).to receive(:lines).once
      subject.screen_rows
    end
  end

  describe "#screen_columns" do
    it "calls cols" do
      expect(Curses).to receive(:cols).once
      subject.screen_columns
    end
  end

  describe "#insert_char_before_cursor" do
    it "calls insch" do
      expect(Curses).to receive(:insch).once
      subject.insert_char_before_cursor("X")
    end
  end

  describe "#display" do
    describe "config" do
      it "calls nonl" do
        expect(Curses).to receive(:nonl).once
        subject.display { subject.silent_keys }
      end

      it "calls keypad with true on stdscr" do
        expect(Curses.stdscr).to receive(:keypad).with(true).once
        subject.display { subject.silent_keys }
      end

      it "calls raw" do
        expect(Curses).to receive(:raw).once
        subject.display { subject.silent_keys }
      end

      it "calls init_screen" do
        expect(Curses).to receive(:init_screen).once
        subject.display { subject.silent_keys }
      end

      it "ensures clear is called" do
        expect(Curses).to receive(:clear).once
        subject.display { subject.silent_keys }
      end

      it "ensures close_screen is called" do
        expect(Curses).to receive(:close_screen).once
        subject.display { subject.silent_keys }
      end
    end

    describe "yield" do
    end
  end
end
