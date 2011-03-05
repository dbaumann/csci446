class AddRoleToUser < ActiveRecord::Migration
  def self.up
    #assuming no support for a foreign key constraint in ActiveRecord
    add_column :users, :role_id, :integer, :unique => true
  end

  def self.down
    remove_column :users, :role_id
  end
end
