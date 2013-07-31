get '/board/new' do
  redirect board_request_token.authorize_url
end

get '/board/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
  @board = current_user.boards.find_or_create_by_twitter_name(@access_token.params[:screen_name])
  @board.update_attributes(oauth_token: @access_token.params[:oauth_token], oauth_token_secret: @access_token.params[:oauth_token_secret])
  redirect to("/board/#{@board.twitter_name}/edit")
end

get '/board/:twitter_name/edit' do
  @board = Board.find_by_twitter_name(params[:twitter_name])
  erb :edit_board
end

get '/board/:twitter_name' do
  @board = Board.find_by_twitter_name(params[:twitter_name])
  @board.load_new_posts
  if request.xhr?
    erb :_bulletin, layout: false, locals: {post: @board.next_post}
  else
    erb :board
  end
end

post '/board/:twitter_name/edit' do
  @board = Board.find_by_twitter_name(params[:twitter_name])
  @board.update_attributes(params[:board])
  redirect to("/#{@board.owner.twitter_name}")
end
