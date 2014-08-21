require_relative '../app/models/tictactoe'

describe TicTacToeGame do

  before(:each) do
    @unfinished_game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "X", "", "", "", "", "O", "O"]), player1: Player.new("X"), player2: Player.new("O")})
    @game_that_x_won = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "X", "", "X", "O", "O", "", "O"]), player1: Player.new("X"), player2: Player.new("O")})
    @game_that_o_won = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "O", "X", "X", "O", "", "O", "O"]), player1: Player.new("X"), player2: Player.new("O")})
    @tied_game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "O", "X", "O", "O", "X", "X", "X", "O"]), player1: Player.new("X"), player2: Player.new("O")})
  end

  describe '#finished?' do
    it 'should return true if there are no empty cells' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "O", "X", "O", "O", "X", "X", "X", "O"]), player1: Player.new("X"), player2: Player.new("O")})
      expect(game.finished?).to be true
    end

    it 'should return true if there are three Xs or Os in one row' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "X", "", "X", "O", "O", "", "O"]), player1: Player.new("X"), player2: Player.new("O")})
      expect(game.finished?).to be true
    end

    it 'should return true if there are three Xs or Os in one column' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "O", "X", "", "O", "X", "", "O", "O"]), player1: Player.new("X"), player2: Player.new("O")})
      expect(game.finished?).to be true
    end

    it 'should return true if there are three Xs or Os on a diagonal' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "O", "X", "O", "X", "", "", "O", "X"]), player1: Player.new("X"), player2: Player.new("O")})
      expect(game.finished?).to be true
    end

    it 'should return false if there are empty cells and no three Xs or Os in a row' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "", "", "", "", "", "", "O", "X"]), player1: Player.new("X"), player2: Player.new("O")})
      expect(game.finished?).to be false
    end
  end

  describe '#find_winner' do
    it 'should return X if X won' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "X", "", "X", "O", "O", "", "O"]), player1: Player.new("X"), player2: Player.new("O")})
       expect(game.winning_marker).to eq("X")
    end

    it 'should return O if O won' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "O", "X", "X", "O", "", "O", "O"]), player1: Player.new("X"), player2: Player.new("O")})
      expect(game.winning_marker).to eq("O")
    end

    it 'should return nil if the game is not finished' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "", "", "", "", "", "", "O", "X"]), player1: Player.new("X"), player2: Player.new("O")})
      expect(game.winning_marker).to eq(nil)
    end

    it 'should return nil if the game is a tie' do
      game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "O", "X", "O", "O", "X", "X", "X", "O"]), player1: Player.new("X"), player2: Player.new("O")})
      expect(game.winning_marker).to eq(nil)
    end
  end


end
