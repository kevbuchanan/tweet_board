class Board < ActiveRecord::Base
  has_many :posts
  belongs_to :owner, class_name: "User"
  has_many :contributors_boards
  has_many :contributors, through: :contributors_boards

  after_create :add_owner_as_contributor

  def load_new_posts
    self.new_mentions.each do |tweet|
      self.posts << Post.create_from_tweet(tweet) if self.has_contributor?(tweet.user.screen_name)
    end
  end

  def next_post
    self.posts.sample
  end

  def add_owner_as_contributor
    self.contributors.create(twitter_name: self.owner.twitter_name)
  end

  def has_contributor?(user_name)
    !self.contributors.find_by_twitter_name(user_name).nil?
  end

  def new_mentions
    client = Twitter::Client.new(oauth_token: self.oauth_token, oauth_token_secret: self.oauth_token_secret)
    client.mentions_timeline
  end
end
