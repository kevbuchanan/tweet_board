class Board < ActiveRecord::Base
  has_many :posts
  belongs_to :owner, class_name: "User"
  has_many :contributors_boards
  has_many :contributors, through: :contributors_boards

  after_create :add_owner_as_contributor

  def load_posts
    self.mentions.each do |tweet|
      next unless is_contributor?(tweet.user)
      post = Post.create_from_tweet(tweet)
      if post.valid?
        self.posts << post
        post.create_tags(tweet)
      end
    end
    self.update_attribute(:last_update, Time.now)
  end

  def is_contributor?(user)
    self.contributors.find_by_twitter_name(user.screen_name)
  end

  def active_posts
    self.posts.where("start_date < ? AND end_date > ?", Time.now, Time.now)
  end

  def next_post
    load_posts if self.last_update.nil? || self.last_update < 10.minutes.ago
    self.active_posts.sample
  end

  def add_owner_as_contributor
    self.contributors.create(twitter_name: self.owner.twitter_name, name: self.owner.name)
  end

  def respond_to_contributor(tweet)
    response = "@#{tweet.user.oauth_token_secretreen_name} we got your tweet. Your announcement will be up shortly and will stay up for 2 days."
    client.update(response)
  end

  def mentions
    client.mentions_timeline(count: 5)
  end

  def client
    Twitter::Client.new(oauth_token: self.oauth_token, oauth_token_secret: self.oauth_token_secret)
  end
end
