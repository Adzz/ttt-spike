RSpec.describe Board do
  describe "#update_state" do
    let(:visual_board) { instance_double VisualBoard }

    subject { described_class.new(visual_board: visual_board) }
    
    before { allow(visual_board).to receive(:renderable_board) }

    it 'updates the state of a board for the given position and player' do
      expect(subject.update_state(4, 'X')).to eq [0,1,2,3,'X',5,6,7,8]
      expect(subject.state).to eq [0,1,2,3,'X',5,6,7,8]
    end

    it "sends a message to the visual board to update it's state" do
      expect(visual_board).to receive(:renderable_board).with([0,1,2,3,'X',5,6,7,8]).once
      subject.update_state(4, 'X')
    end
  end

  describe "#state" do
    it 'returns the state of the board' do
      expect(subject.state).to eq [*0..8]
    end
  end

  describe "#game_over?" do
    it "returns true when X wins" do
      x_winning_combos.each do |combo|
        expect(Board.new(state: combo).game_over?).to be true
      end
    end

    it "returns true when O wins" do
      x_winning_combos.each do |combo|
        combo.map! { |x| x == "X" ? "O" : x }
        expect(Board.new(state: combo).game_over?).to be true
      end
    end

    it "returns true when there are no free spaces left" do
      expect(Board.new(state: ["X","O","X","O","X","O","O","X","X"]).game_over?).to be true
    end

    it "returns false when no one has one AND the board isn't full" do
      expect(Board.new(state: ["X","O","X","O","X","O",6,"X",8]).game_over?).to be false
    end
  end

  describe "#winning_board_for?" do
    context 'when player is X' do
      let(:player) { "X" }

      it 'returns true if X take the top row' do
        board = Board.new(state: ["X","X","X",3,4,5,6,7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes the middle row' do
        board = Board.new(state: [0,1,2,"X","X","X",6,7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes the bottom row' do
        board = Board.new(state: [0,1,2,3,4,5,"X","X","X"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X take the left column' do
        board = Board.new(state: ["X",1,2,"X",4,5,"X",7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes the middle column' do
        board = Board.new(state: [0,"X",2,3,"X",5,6,"X",8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes the right column' do
        board = Board.new(state: [0,1,"X",3,4,"X",6,7,"X"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes diagonal top right to bottom left' do
        board = Board.new(state: [0,1,"X",3,"X",5,"X",7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if X takes diagonal top left to bottom right' do
        board = Board.new(state: ["X",1,2,3,"X",5,6,7,"X"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns false if X or O do not take a winning row' do
        expect(subject.winning_board_for?(player)).to be false
        board = Board.new(state: ["X", "O",2,3,4,5,"X","O",8])
        expect(board.winning_board_for?(player)).to be false
      end
    end

    context 'when player is O' do
      let(:player) { "O" }

      it 'returns true if O take the top row' do
        board = Board.new(state: ["O","O","O",3,4,5,6,7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes the middle row' do
        board = Board.new(state: [0,1,2,"O","O","O",6,7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes the bottom row' do
        board = Board.new(state: [0,1,2,3,4,5,"O","O","O"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O take the left column' do
        board = Board.new(state: ["O",1,2,"O",4,5,"O",7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes the middle column' do
        board = Board.new(state: [0,"O",2,3,"O",5,6,"O",8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes the right column' do
        board = Board.new(state: [0,1,"O",3,4,"O",6,7,"O"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes diagonal top right to bottom left' do
        board = Board.new(state: [0,1,"O",3,"O",5,"O",7,8])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns true if O takes diagonal top left to bottom right' do
        board = Board.new(state: ["O",1,2,3,"O",5,6,7,"O"])
        expect(board.winning_board_for?(player)).to be true
      end

      it 'returns false if X or O do not take a winning row' do
        expect(subject.winning_board_for?(player)).to be false

        board = Board.new(state: ["X", "O",2,3,4,5,"X","O",8])
        expect(board.winning_board_for?(player)).to be false
      end
    end
  end

  def x_winning_combos
    [
      ["X","X","X",3,4,5,6,7,8],
      [0,1,2,"X","X","X",6,7,8],
      [0,1,2,3,4,5,"X","X","X"],
      ["X",1,2,"X",4,5,"X",7,8],
      [0,1,"X",3,"X",5,"X",7,8],
      ["X",1,2,3,"X",5,6,7,"X"],
      [0,"X",2,3,"X",5,6,"X",8],
      [0,1,"X",3,4,"X",6,7,"X"]
    ]
  end
end
