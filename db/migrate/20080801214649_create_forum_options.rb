class CreateForumOptions < ActiveRecord::Migration
  def self.up
    create_table :forum_options do |t|
      t.string :name
      t.string :value
      t.integer :forum_id, :deferrable => true

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_options
  end
end
