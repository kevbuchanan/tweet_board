class User < ActiveRecord::Base
  has_many :boards, foreign_key: "creator_id"

end
