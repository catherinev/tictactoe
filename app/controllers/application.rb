get '/' do

  erb :index
end

post '/play' do
  
  if request.xhr?
    ["X", "X", "X", "X", "X", "X", "X", "X", "X"]
  else

  end
end
