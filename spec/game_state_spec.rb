RSpec.describe GameState do
  context 'checking for an illegal board' do
    it 'player cant be O if there is no X on the board (X goes first)' do
      expect { GameState.new("O", Board.new(state: [1,2,3])) }.to raise_exception(ArgumentError)
    end

    it "player can't be X if it's O's turn" do
      expect { GameState.new("X", Board.new(state: ["X","O","X",3])) }.to raise_exception(ArgumentError)
    end

    it "player can't be O if it's X's turn" do
      expect { GameState.new("O", Board.new(state: ["X","O",2])) }.to raise_exception(ArgumentError)
    end
  end

  context 'successors' do
    context "when player is X" do
      it "will generate successors for each possible next move" do
        game_state = GameState.new("X", Board.new(state: [0,1]))
        expect(game_state.successors.map(&:current_state)).to eq [["X",1],[0,"X"]]
      end

      context "will not generate successors:" do
        it 'with an X where an X was' do
          game_state = GameState.new("X", Board.new(state: [0,"X","O",3]))
          expect(game_state.successors.map(&:current_state)).to eq [["X","X","O",3],[0,"X","O","X"]]
        end

        it 'with an X where an O was' do
          game_state = GameState.new("X", Board.new(state: ["O","X",3]))
          expect(game_state.successors.map(&:current_state)).to eq [["O","X","X"]]
        end

        # it "when the board state is an end state" do
        #   game_state = GameState.new("X", Board.new(state: ["O",1,"O",3,"O",5,"X","X","X"]))
        #   expect(game_state.successors).to eq []
        # end
      end
    end

    context "when player is O" do
      it "will generate successors for each possible next move" do
        game_state = GameState.new("O", Board.new(state: ["X",1,2]))
        expect(game_state.successors.map(&:current_state)).to eq [["X", "O", 2], ["X", 1, "O"]]
      end

      context "will not generate successors with an O in an illegal place:" do
        it 'with an O where an X was' do
          game_state = GameState.new("O", Board.new(state: [0,"X"]))
          expect(game_state.successors.map(&:current_state)).to eq [["O","X"]]
        end

        it 'with an O where an O was' do
          game_state = GameState.new("O", Board.new(state: ["O","X","X",3]))
          expect(game_state.successors.map(&:current_state)).to eq [["O","X","X","O"]]
        end

        # it "when the board state is an end state" do
        #   game_state = GameState.new("O", Board.new(state: ["X",2,"X","X","X",5,"O","O","O"]))
        #   expect(game_state.successors).to eq []
        # end
      end
    end
  end

  context 'lost?' do
    it 'returns true if the current player lost'do
      game_state = GameState.new("X", Board.new(state: ["O","O","O",3,"X",5,"X","X",8]))
      expect(game_state.lost?).to be true
    end
  end

  context 'won' do
    it 'returns true when the current player won' do
      game_state = GameState.new("X", Board.new(state: ["X","X","X",3,"O","O","O",7,8]))
      expect(game_state.won?).to be true
    end

    it 'returns false if they didnt' do
      game_state = GameState.new("X", Board.new(state: [*0..8]))
      expect(game_state.won?).to be false
      game_state = GameState.new("X", Board.new(state: ["O","O",2,3,"X",5,6,"X",8]))
      expect(game_state.won?).to be false
    end
  end
end
