# require 'tweetstream'

# TweetStream.configure do |config|
#   config.consumer_key       = ENV['TWITTER_KEY']
#   config.consumer_secret    = ENV['TWITTER_SECRET']
#   config.oauth_token        = ENV['OAUTH_TOKEN']
#   config.oauth_token_secret = ENV['OAUTH_SECRET']
#   config.auth_method        = :oauth
# end

# TweetStream::Daemon.new.follow(1633985923) do |tweet|
#   board = Board.find_by_twitter_name(tweet.in_reply_to_screen_name)
#   board.posts << Post.create_from_tweet(tweet) if board.has_contributor?(tweet.user.screen_name)
# end
