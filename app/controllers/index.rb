get '/' do
  erb :index
end

get '/sign_in' do
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
  @user = User.authenticate(@access_token)
  @user.update_attributes(oauth_token: @access_token.params[:oauth_token], oauth_token_secret: @access_token.params[:oauth_token_secret])
  session[:id] = @user.id
  redirect to("/#{@user.twitter_name}")
end

get '/:twitter_name' do
  @user = User.find_by_twitter_name(params[:twitter_name])
  erb :user
end
