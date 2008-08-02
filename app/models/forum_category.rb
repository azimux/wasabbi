class ForumCategory < ActiveRecord::Base
  has_many :forums
end
