class ContributorsBoard < ActiveRecord::Base
  belongs_to :contributor
  belongs_to :board

end
