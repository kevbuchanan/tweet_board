class Post < ActiveRecord::Base
  belongs_to :board
  belongs_to :contributor
  has_many :posts_tags
  has_many :tags, through: :posts_tags
end
