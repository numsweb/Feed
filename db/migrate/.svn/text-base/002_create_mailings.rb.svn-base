class CreateMailings < ActiveRecord::Migration
  def self.up
    create_table :mailings do |t|
      t.integer :feed_id
      t.text :message_body
      t.string :message_subject
      t.timestamps
    end
  end

  def self.down
    drop_table :mailings
  end
end
