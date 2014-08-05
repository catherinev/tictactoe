require_relative '../app/models/tictactoe'

describe 'Check that computer always wins' do

  describe "when starting position is corner" do
    it 'should win when opponent starts with position 0' do
      game = Game.new(["X", "", "", "", "", "", "", "", ""])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end

    it 'should win when opponent starts with position 2' do
      game = Game.new(["", "", "X", "", "", "", "", "", ""])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end

    it 'should win when opponent starts with position 6' do
      game = Game.new(["", "", "", "", "", "", "X", "", ""])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end

    it 'should win when opponent starts with position 8' do
      game = Game.new(["", "", "", "", "", "", "", "", "X"])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end
  end

  describe 'when starting position is center' do
    it 'should win when opponent starts with position 4' do
      game = Game.new(["", "", "", "", "X", "", "", "", ""])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end
  end

  describe 'when starting position is edge' do

    it 'should win when opponent starts with position 1' do
      game = Game.new(["", "X", "", "", "", "", "", "", ""])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end

    it 'should win when opponent starts with position 3' do
      game = Game.new(["", "", "", "X", "", "", "", "", ""])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end

    it 'should win when opponent starts with position 5' do
      game = Game.new(["", "", "", "", "", "X", "", "", ""])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end

    it 'should win when opponent starts with position 7' do
      game = Game.new(["", "", "", "", "", "", "", "X", ""])
      until game.finished?
        game.smart_play
        game.random_play("X")
      end
      expect(game.winner).to_not eq("X")
    end
  end  
end
