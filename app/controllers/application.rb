get '/' do

  erb :index
end

post '/play' do
  @next_board = ["X", "X", "X", "X", "X", "X", "X", "X", "X"]
  if request.xhr?
    @next_board
  else

  end
end
