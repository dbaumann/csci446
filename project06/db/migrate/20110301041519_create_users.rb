class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :role_id
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
