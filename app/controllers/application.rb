require_relative '../models/tictactoe'

get '/' do
  erb :index
end

post '/play' do
  @game = Game.new(params[:board])
  @game.smart_play
  {board: @game.board, finished: @game.finished?, winner: @game.find_winner}.to_json
end
