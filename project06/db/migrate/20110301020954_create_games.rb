class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :title, :null => false
      t.integer :rating, :default => 1, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
