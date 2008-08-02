class CreateForums < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :forums do |t|
        t.string :name
        t.string :description
        t.integer :parent_id, :deferrable => true
        t.integer :forum_category_id, :deferrable => true

        t.timestamps
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :forums
    end
  end
end
