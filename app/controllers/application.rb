get '/' do

  erb :index
end

post '/play' do
  board = params[:board]
  
  empty_elements = []
  board.each_with_index do |element, index|
    if element == ""
      empty_elements << index
    end
  end
  new_play = empty_elements.sample

  @next_board = board.dup
  @next_board[new_play] = "O"
  p @next_board

  if request.xhr?
    @next_board.to_json
  else

  end
end
