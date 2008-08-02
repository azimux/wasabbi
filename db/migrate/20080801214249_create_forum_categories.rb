class CreateForumCategories < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :forum_categories do |t|
        t.string :name
        t.string :description
        t.integer :position

        t.timestamps
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :forum_categories
    end
  end
end
