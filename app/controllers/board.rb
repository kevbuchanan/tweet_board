get '/board/new' do
  redirect board_request_token.authorize_url
end

get '/board/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
  @board = Board.find_or_create_by_twitter_name(@access_token.params[:screen_name])
  @board.update_attributes(oauth_token: @access_token.params[:oauth_token], oauth_token_secret: @access_token.params[:oauth_token_secret])
  redirect to("/board/#{@board.twitter_name}/edit")
end

get '/board/:twitter_name/edit' do
  @board = Board.find_by_twitter_name(params[:twitter_name])
  erb :edit_board
end

get '/board/:twitter_name' do
  @board = Board.find_by_twitter_name(params[:twitter_name])
  erb :board
end