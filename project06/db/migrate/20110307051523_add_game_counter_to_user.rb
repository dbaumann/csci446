class AddGameCounterToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :games_count, :integer, :default => 0
    User.reset_column_information
    User.find(:all).each do |user|
      user.update_attribute :games_count, user.games.length
    end
  end

  def self.down
    remove_column :users, :games_count
  end
end
