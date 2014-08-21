require_relative '../models/tictactoe'

get '/' do
  erb :index
end

post '/play' do
  game_board = TicTacToeBoard.new(params[:board])
  computer = Player.new("O")
  opponent = Player.new("X")
  game = TicTacToeGame.new({board: game_board, player1: computer, player2: opponent})

  unless game.finished?
    computer.smart_play
  end
  {board: game_board.board, finished: game.finished?, winner: game.find_winner}.to_json
end
