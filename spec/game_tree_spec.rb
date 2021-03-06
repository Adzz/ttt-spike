RSpec.describe GameTree do
  context 'when computer is X' do
    it 'suggests a winning move when there is a winning move to make.' do
      gt = described_class.new(GameState.new("X", Board.new(state: ["O",1,"X","X",4,5,"X","O","O"])))
      expect(gt.choose_move).to eq ["O",1,"X","X","X",5,"X","O","O"]
    end

    it "will block an opponent's winning move" do
      gt = described_class.new(GameState.new("X", Board.new(state: ["O","O",2,3,"X",5,6,"X",8])))
      expect(gt.choose_move).to eq ["O","O","X",3,"X",5,6,"X",8]
    end

    it "will chose a winning move over blocking an opponent's winning move" do
      gt = described_class.new(GameState.new("X", Board.new(state: ["O","O",2,"X","X",5,6,7,8])))
      expect(gt.choose_move).to eq ["O","O",2,"X","X","X",6,7,8]
    end

    it "will never select an edge as a first move for X" do
      gt = described_class.new(GameState.new("X", Board.new(state: [*0..8])))
      expect(gt.choose_move).to eq ["X",1,2,3,4,5,6,7,8]
    end
  end

  context 'When computer is O' do
    it "suggests the optimal first move for O's first move" do
      gt = described_class.new(GameState.new("O", Board.new(state: ["X",1,2,3,4,5,6,7,8])))
      expect(gt.choose_move).to eq ["X",1,2,3,"O",5,6,7,8]
    end

    it 'suggests a winning move when there is a winning move to make.' do
      gt = described_class.new(GameState.new("O", Board.new(state: [0,"X","O","X","O","X",6,7,8])))
      expect(gt.choose_move).to eq [0,"X","O","X","O","X","O",7,8]
    end

    context "will block an opponent's winning move" do
      it 'O center' do
        gt = described_class.new(GameState.new("O", Board.new(state: ["O",1,2,"X","X",5,6,7,8])))
        expect(gt.choose_move).to eq ["O",1,2,"X","X","O",6,7,8]
      end

      context 'X in corner' do
        it '1' do
          gt = described_class.new(GameState.new("O", Board.new(state: ["X","O","X","O","O","X",6,"X",8])))
          expect(gt.choose_move).to eq ["X","O","X","O","O","X",6,"X","O"]
        end

        it '2' do
          gt = described_class.new(GameState.new("O", Board.new(state: ["X",1,2,"X","O",5,6,7,8])))
          expect(gt.choose_move).to eq ["X",1,2,"X","O",5,"O",7,8]
        end

        it '2' do
          gt = described_class.new(GameState.new("O", Board.new(state: ["X",1,2,3,"O",5,"X",7,8])))
          expect(gt.choose_move).to eq ["X",1,2,"O","O",5,"X",7,8]
        end

        it '3' do
          gt = described_class.new(GameState.new("O", Board.new(state: ["X","X",2,3,"O",5,6,7,8])))
          expect(gt.choose_move).to eq ["X","X","O",3,"O",5,6,7,8]
        end

        it '4' do
          gt = described_class.new(GameState.new("O", Board.new(state: ["X",1,"X",3,"O",5,6,7,8])))
          expect(gt.choose_move).to eq ["X","O","X",3,"O",5,6,7,8]
        end

        it '5' do
          gt = described_class.new(GameState.new("O", Board.new(state: ["X",1,"O",3,"X",5,6,7,8])))
          expect(gt.choose_move).to eq ["X",1,"O",3,"X",5,6,7,"O"]
        end

        it '5' do
          gt = described_class.new(GameState.new("O", Board.new(state: ["X",1,"O",3,4,5,6,7,"X"])))
          expect(gt.choose_move).to eq ["X",1,"O",3,"O",5,6,7,"X"]
        end
      end
    end

    it "will chose a winning move over blocking an opponent's winning move" do
      gt = described_class.new(GameState.new("O", Board.new(state: ["X","X",2,"X",4,5,"O","O",8])))
      expect(gt.choose_move).to eq ["X","X",2,"X",4,5,"O","O","O"]
    end
  end
end
