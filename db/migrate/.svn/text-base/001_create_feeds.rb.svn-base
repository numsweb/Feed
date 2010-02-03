class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string :link, :heading, :title
      t.boolean :is_read, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
