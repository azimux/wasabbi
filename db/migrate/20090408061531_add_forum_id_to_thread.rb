class AddForumIdToThread < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_threads, :forum_id, :integer,
        :references => :wasabbi_forums, :null => false
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_threads, :forum_id
    end
  end
end
