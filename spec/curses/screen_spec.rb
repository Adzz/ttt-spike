RSpec.describe CursesWrapper::Screen do
  subject { described_class.new(Curses) }

  context 'config' do
    describe "#silent_keys" do
      it "calls noecho" do
        expect(Curses).to receive(:noecho).once
        subject.silent_keys
      end
    end

    describe "#enable_keyboard" do
      it "calls raw" do
        expect(Curses).to receive(:raw).once
        subject.enable_keyboard
      end
    end

    describe "#enable_enter_key" do
      it "calls nonl" do
        expect(Curses).to receive(:nonl).once
        subject.enable_enter_key
      end
    end

    describe "#init_screen" do
      it "calls init_screen" do
        expect(Curses).to receive(:init_screen).once
        subject.init_screen
      end
    end

    describe "#enable_function_keys" do
      it "calls keypad" do
        expect(Curses.stdscr).to receive(:keypad).with(true).once
        subject.enable_function_keys
      end
    end

    describe "#quit_cleanly" do
      it "calls clear" do
        expect(Curses.stdscr).to receive(:clear).once
        subject.quit_cleanly
      end

      it "calls screen close" do
        expect(Curses).to receive(:close_screen).once
        subject.quit_cleanly
      end
    end

    describe "#screen" do
      it "calls stdscr" do
        expect(Curses).to receive(:stdscr).once
        subject.screen
      end
    end

    describe "#clear" do
      it "calls clear" do
        expect(Curses.stdscr).to receive(:clear).once
        subject.clear
      end
    end

    describe "#refresh" do
      it "calls doupdate" do
        expect(Curses).to receive(:doupdate).once
        subject.refresh
      end
    end

    describe "#screen_refresh" do
      it "calls refresh on stdscreen" do
        expect(Curses.stdscr).to receive(:refresh).once
        subject.screen_refresh
      end
    end
  end

  context 'printing to the screen' do
    let(:string) { "aww yis" }

    describe "#add_string" do
      it "calls addstr" do
        expect(Curses).to receive(:addstr).with(string).once
        subject.add_string(string)
      end
    end

    describe "#type" do
      it "adds a string one char at a time" do
        expect(Curses).to receive(:addstr).exactly(string.length).times
        expect(Curses.stdscr).to receive(:refresh).exactly(string.length).times
        subject.type(string)
      end
    end

    describe "#position_and_type_from_center" do
      it "types to the screen" do
        expect(subject).to receive(:type).with(string, anything).once
        subject.position_and_type_from_center(string)
      end
    end

    describe "#delete_char_under_cursor" do
      it "calls delch" do
        expect(Curses).to receive(:delch).once
        subject.delete_char_under_cursor
      end
    end

    describe "#insert_char_before_cursor" do
      it "calls insch" do
        expect(Curses).to receive(:insch).once
        subject.insert_char_before_cursor("X")
      end
    end

    describe "#border" do
      it "calls box on stdscr" do
        expect(Curses.stdscr).to receive(:box).with("|", "-").once
        subject.border("|", "-")
      end
    end

    describe "#display" do
      describe "config" do
        specify { expect { |bloc| subject.display(&bloc) }.to yield_with_no_args }

        it "enables  the enter_key" do
          expect(Curses).to receive(:nonl).once
          subject.display { subject.silent_keys }
        end

        it "enables function keys" do
          expect(Curses.stdscr).to receive(:keypad).with(true).once
          subject.display { subject.silent_keys }
        end

        it "enables the standard keyboard" do
          expect(Curses).to receive(:raw).once
          subject.display { subject.silent_keys }
        end

        it "initializes a standard screen" do
          expect(Curses).to receive(:init_screen).once
          subject.display { subject.silent_keys }
        end

        it "ensure clear is called" do
          expect(Curses.stdscr).to receive(:clear).once
          subject.display { subject.silent_keys }
        end

        it "ensures close_screen is called" do
          expect(Curses).to receive(:close_screen).once
          subject.display { subject.silent_keys }
        end
      end
    end

    describe "#move_cursor_to" do
      it "calls setpos" do
        expect(Curses).to receive(:setpos).with(1, 3).once
        subject.move_cursor_to(1, 3)
      end
    end
  end

  context 'reading from the screen' do
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

    describe "#get_string" do
      it "calls getstr" do
        expect(Curses).to receive(:getstr).once
        subject.get_string
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
  end
end
