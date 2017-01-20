RSpec.describe VisualBoard do
  describe '#renderable_board' do
    let(:curses) {  double Curses }
    before do
      allow(curses).to receive(:position_and_type_from_center)
      allow(curses).to receive(:border)
    end

    subject { described_class.new(view: curses) }

    let(:empty_state) do
      [
        "           |     |          ",
        "           |     |          ",
        "      _____|_____|_____     ",
        "           |     |          ",
        "           |     |          ",
        "      _____|_____|_____     ",
        "           |     |          ",
        "           |     |          ",
        "           |     |          "
      ]
    end

    let(:x_top_left) do
      [
        "           |     |          ",
        "        X  |     |          ",
        "      _____|_____|_____     ",
        "           |     |          ",
        "           |     |          ",
        "      _____|_____|_____     ",
        "           |     |          ",
        "           |     |          ",
        "           |     |          "
      ]
    end

    it 'generates a representation of the given board state that can be rendered' do
      subject.render_board([*0..8])
      expect(subject.visual_board_lines).to eq empty_state
      subject.render_board(["X",1,2,3,4,5,6,7,8])
      expect(subject.visual_board_lines).to eq x_top_left
    end

    it 'tells the front end to render the board' do
      expect(curses).to receive(:position_and_type_from_center).exactly(subject.height + 1).times
      subject.render_board([*0..8])
    end
  end

  describe '#height' do
    it 'returns the visual hieght of the board' do
      expect(subject.height).to eq 9
    end
  end

  describe '#width' do
    it 'returns the visual width of the board' do
      expect(subject.width).to eq 28
    end
  end
end