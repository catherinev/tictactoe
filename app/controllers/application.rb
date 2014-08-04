require_relative '../models/tictactoe'

get '/' do

  erb :index
end

post '/play' do
  @game = Game.new(params[:board])
  
  @game.random_play

  if request.xhr?
    @game.board.to_json
  else

  end
end
