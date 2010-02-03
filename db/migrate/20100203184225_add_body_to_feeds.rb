class AddBodyToFeeds < ActiveRecord::Migration
  def self.up
    add_field :feeds, :feed_body, :text
  end

  def self.down
    remove_field :feeds, :feed_body
  end
end
