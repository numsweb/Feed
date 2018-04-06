class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :feed_url
      t.datetime :published
      t.text :summary
      t.boolean :is_read, :default => false
      t.timestamps
    end
    add_index :feeds, [:title, :published]
  end
end
