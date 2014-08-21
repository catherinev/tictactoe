require_relative '../app/models/tictactoe'

describe 'Check that computer always wins' do
  before(:each) do
    @player1 = Player.new("X")
    @player2 = Player.new("O")
  end

  describe "when starting position is corner" do
    it 'should win when opponent starts with position 0' do
      game_board = TicTacToeBoard.new(["X", "", "", "", "", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end

    it 'should win when opponent starts with position 2' do
      game_board = TicTacToeBoard.new(["", "", "X", "", "", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end

    it 'should win when opponent starts with position 6' do
      game_board = TicTacToeBoard.new(["", "", "", "", "", "", "X", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end

    it 'should win when opponent starts with position 8' do
      game_board = TicTacToeBoard.new(["", "", "", "", "", "", "", "", "X"])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end
  end

  describe 'when starting position is center' do
    it 'should win when opponent starts with position 4' do
      game_board = TicTacToeBoard.new(["", "", "", "", "X", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end
  end

  describe 'when starting position is edge' do

    it 'should win when opponent starts with position 1' do
      game_board = TicTacToeBoard.new(["", "X", "", "", "", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end

    it 'should win when opponent starts with position 3' do
      game_board = TicTacToeBoard.new(["", "", "", "X", "", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end

    it 'should win when opponent starts with position 5' do
      game_board = TicTacToeBoard.new(["", "", "", "", "", "X", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end

    it 'should win when opponent starts with position 7' do
      game_board = TicTacToeBoard.new(["", "", "", "", "", "", "", "X", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})
      until game.finished?
        @player1.random_play
        @player2.smart_play
      end
      expect(game.winning_marker).to_not eq("X")
    end
  end  
end
