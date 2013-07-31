class Post < ActiveRecord::Base
  belongs_to :board
  belongs_to :contributor
  has_many :posts_tags
  has_many :tags, through: :posts_tags

  def self.create_from_tweet(tweet)
    contributor = Contributor.find_or_create_by_twitter_name(tweet.user.screen_name)
    text = tweet.text
    start_date = Time.now
    end_date = Time.now + 1.week
    contributor.posts.create(text: tweet.text, start_date: start_date, end_date: end_date)
  end
end
