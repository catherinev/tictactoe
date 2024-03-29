require_relative '../app/models/tictactoe'

describe 'when both players are smart, game always wins in a tie' do
  before(:each) do
    @player1 = Player.new("X")
    @player2 = Player.new("O")
  end

  describe "when starting position is corner" do
    it 'should not lose when opponent starts with position 0' do
      game_board = TicTacToeBoard.new(["X", "", "", "", "", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end

    it 'should not lose when opponent starts with position 2' do
      game_board = TicTacToeBoard.new(["", "", "X", "", "", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end

    it 'should not lose when opponent starts with position 6' do
      game_board = TicTacToeBoard.new(["", "", "", "", "", "", "X", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end

    it 'should not lose when opponent starts with position 8' do
      game_board = TicTacToeBoard.new(["", "", "", "", "", "", "", "", "X"])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end
  end

  describe 'when starting position is center' do
    it 'should not lose when opponent starts with position 4' do
      game_board = TicTacToeBoard.new(["", "", "", "", "X", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end
  end

  describe 'when starting position is edge' do

    it 'should not lose when opponent starts with position 1' do
      game_board = TicTacToeBoard.new(["", "X", "", "", "", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end

    it 'should not lose when opponent starts with position 3' do
      game_board = TicTacToeBoard.new(["", "", "", "X", "", "", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end

    it 'should not lose when opponent starts with position 5' do
      game_board = TicTacToeBoard.new(["", "", "", "", "", "X", "", "", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end

    it 'should not lose when opponent starts with position 7' do
      game_board = TicTacToeBoard.new(["", "", "", "", "", "", "", "X", ""])
      game = TicTacToeGame.new({board: game_board, player1: @player1, player2: @player2})      
      until game.finished?
        @player2.smart_play
        @player1.smart_play
      end
      expect(game.winning_marker).to be nil
    end
  end  
end
