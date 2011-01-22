class AddPriceToProduct < ActiveRecord::Migration
  def self.up
    #table, column_name, column_type, additional_args
    add_column :products, :price, :decimal,
      :precision => 8, :scale => 2, :default => 0
      #8 sig figs, 2 decimals of accuracy, default value of 0
      #notice how the these characteristics can be specified in a database-independent
      #manner using migrations
  end

  def self.down
    remove_column :products, :price
  end
end
