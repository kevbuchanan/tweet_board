class Post < ActiveRecord::Base
  belongs_to :board
  belongs_to :contributor
  has_many :posts_tags
  has_many :tags, through: :posts_tags
  validates :tweet_id, uniqueness: true

  def self.create_from_tweet(tweet)
    contributor = Contributor.find_or_create_by_twitter_name(tweet.user.screen_name)
    text = tweet.text
    tweet_id = tweet.id
    start_date = Time.now
    end_date = Time.now + 1.week
    contributor.posts.create(text: tweet.text, start_date: start_date, end_date: end_date, tweet_id: tweet_id)
  end
end
