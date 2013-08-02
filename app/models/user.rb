class User < ActiveRecord::Base
  has_many :boards, foreign_key: "owner_id"
  after_create :get_name

  def self.authenticate(access_token)
    user = User.find_by_twitter_name(access_token.params[:screen_name])
    if user
      user
    else
      User.create(
        twitter_name: access_token.params[:screen_name],
        oauth_token: access_token.params[:oauth_token],
        oauth_token_secret: access_token.params[:oauth_token_secret])
    end
  end

  def get_name
    self.name = client.user.name
    self.save
  end

  def client
    Twitter::Client.new(oauth_token: self.oauth_token, oauth_token_secret: self.oauth_token_secret)
  end
end
