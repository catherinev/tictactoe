require_relative '../app/models/tictactoe'

describe Player do
  before(:each) do
    @unfinished_game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "X", "", "", "", "", "O", "O"]), player1: Player.new("X"), player2: Player.new("O")})
    @game_that_x_won = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "X", "", "X", "O", "O", "", "O"]), player1: Player.new("X"), player2: Player.new("O")})
    @game_that_o_won = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "X", "O", "X", "X", "O", "", "O", "O"]), player1: Player.new("X"), player2: Player.new("O")})
    @tied_game = TicTacToeGame.new({board: TicTacToeBoard.new(["X", "O", "X", "O", "O", "X", "X", "X", "O"]), player1: Player.new("X"), player2: Player.new("O")})
  end

  # describe '#random_play' do
  #   it 'should not change existing elements on the board' do
  #     game = Game.new({board: ["", "", "", "","X","","","",""]})
  #     expect{ game.random_play }.to_not change{game.board[4]}
  #   end

  #   it 'should add an \'O\' to the board' do
  #     game = Game.new({board: ["X", "", "", "","","","","",""]})
  #     game.random_play
  #     expect(game.board).to include("O")
  #   end
  # end


end
