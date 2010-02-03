class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :keep_time, :default => "60"
      t.boolean :purge, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
