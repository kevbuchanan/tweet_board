class User < ActiveRecord::Base
  has_many :boards, foreign_key: "owner_id"

end
