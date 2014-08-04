require_relative '../models/tictactoe'
get '/' do

  erb :index
end

post '/play' do
  @board = Board.new(params[:board])
  
  @board.random_play

  if request.xhr?
    @board.board.to_json
  else

  end
end
