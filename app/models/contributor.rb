class Contributor < ActiveRecord::Base
  has_many :contributors_boards
  has_many :boards, through: :contributors_boards
  has_many :posts

  validates :twitter_name, uniqueness: true
end
