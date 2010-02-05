class AddBodyToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :feed_body, :text
  end

  def self.down
    remove_column :feeds, :feed_body
  end
end
