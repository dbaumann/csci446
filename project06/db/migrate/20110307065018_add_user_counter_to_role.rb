class AddUserCounterToRole < ActiveRecord::Migration
  def self.up
    add_column :roles, :users_count, :integer, :default => 0
    Role.reset_column_information
    Role.find(:all).each do |role|
      role.update_attribute :users_count, role.users.length
    end
  end

  def self.down
    remove_column :roles, :users_count
  end
end
