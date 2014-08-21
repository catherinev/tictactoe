require_relative '../app/models/tictactoe'

describe Player do
  before(:each) do
    @player1 = Player.new("X")
    @player2 = Player.new("O")
    @new_board = TicTacToeBoard.new(["", "", "", "", "", "", "", "", ""])
    @unfinished_board = TicTacToeBoard.new(["X", "X", "X", "", "", "", "", "O", "O"])
    @board_that_x_won = TicTacToeBoard.new(["X", "X", "X", "", "X", "O", "O", "", "O"])
    @board_that_o_won = TicTacToeBoard.new(["X", "X", "O", "X", "X", "O", "", "O", "O"])
    @tied_board = TicTacToeBoard.new(["X", "O", "X", "O", "O", "X", "X", "X", "O"])
  end

  describe "#play_cell" do
    before(:each) do
      @example_board = @unfinished_board
      @game = TicTacToeGame.new({board: @example_board, player1: @player1, player2: @player2})
    end
    it "should update the given cell on the given board with the player's marker if the cell is available" do
      @player2.play_cell(4)
      expect(@example_board.board).to eq ["X", "X", "X", "", "O", "", "", "O", "O"]
    end
    it "should not change the board if the given cell is unavailable" do
      expect{@player1.play_cell(0)}.to_not change{@example_board.board}
    end
  end


  describe '#random_play' do
    it 'should not change existing elements on the board' do
      example_board = @unfinished_board
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect{ @player1.random_play}.to_not change{example_board.board[0]}
    end

    it 'should add a marker to the board' do
      example_board = @new_board
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      @player1.random_play
      expect(@new_board.board).to include("X")
    end
  end

  describe '#find_winning_cells' do
    it 'should return the cells a player can play to immediately win' do
      example_board = TicTacToeBoard.new(["X", "X", "", "", "", "", "", "O", "O"])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player1.find_winning_cells).to eq [2]
      expect(@player2.find_winning_cells).to eq [6]
    end

    it 'should return an empty array if there is no winning cell' do
      example_board = @new_board
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player1.find_winning_cells).to eq []
      expect(@player2.find_winning_cells).to eq []
    end
  end

  describe '#find_forks' do
    it 'should return an array with the cell numbers of all cells that are in multiple lines that contain winning cells (opposite corners)' do
      example_board = TicTacToeBoard.new(["X", "", "", "", "O", "", "", "", "X"])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player1.find_forks).to eq [2, 6]
    end

    it 'should return an array with the cell numbers of all cells that are in multiple lines that contain winning cells (center and corner)' do
      example_board = TicTacToeBoard.new(["X", "", "", "", "X", "", "", "", "O"])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player1.find_forks).to eq [1,2, 3, 6]
    end

    it 'should return an array with the cell numbers of all cells that are in multiple lines that contain winning cells (only 1 fork)' do
      example_board = TicTacToeBoard.new(["X", "O", "X", "", "", "", "", "", "O"])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player1.find_forks).to eq [6]
    end

    
    it 'should return an empty array when there are no such forks' do
      example_board = @unfinished_board
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player2.find_forks).to eq []
    end

  end

  describe '#find_opposite_corner' do
    it 'should return the cell number of a corner opposite from a corner containing the player\'s marker' do
      example_board = TicTacToeBoard.new(["X", "", "", "", "", "", "", "", ""])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player1.find_opposite_corner).to eq 8
    end

    it 'should return nil if there are no corners available opposite a corner containing the player\'s marker' do
      example_board = TicTacToeBoard.new(["X", "", "O", "", "", "", "O", "", "X"])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player1.find_opposite_corner).to eq nil
    end
  end

  describe '#block fork' do
    it 'should force the opponent to play a cell that will not create a fork (opposite corners)' do
      example_board = TicTacToeBoard.new(["X", "", "", "", "O", "", "", "", "X"])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player2.block_fork([2,6])).to be 1
    end

    it 'should force the opponent to play a cell that will not create a fork (center and corner)' do
      example_board = TicTacToeBoard.new(["X", "", "", "", "X", "", "", "", "O"])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})
      expect(@player2.block_fork([1, 2, 3, 6])).to be 2
    end

    it 'should force the opponent to play a cell that will not create a fork (only 1 fork)' do
      example_board = TicTacToeBoard.new(["X", "O", "X", "", "", "", "", "", "O"])
      game = TicTacToeGame.new({board: example_board, player1: @player1, player2: @player2})

      expect(@player2.block_fork([6])).to be 4
    end
  end

end
