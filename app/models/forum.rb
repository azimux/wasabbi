class Forum < ActiveRecord::Base
  has_one :parent
  has_one :forum_category

  has_string_hash :forum_options
end
