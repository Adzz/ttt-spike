RSpec.describe VisualBoard do
  describe '#renderable_board' do
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
      expect(subject.renderable_board([*0..8])).to eq empty_state
      expect(subject.renderable_board(["X",1,2,3,4,5,6,7,8])).to eq x_top_left
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