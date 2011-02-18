class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string :name, :null => false

      t.timestamps
    end
    
    add_column :articles, :author_id, :integer
    
    Article.all.each do |article|
      author = Author.create(:name => article.author_name)
      article.author = author
      article.save
    end
    
    remove_column :articles, :author_name
    
  end

  def self.down
    
    add_column :articles, :author_name
    
    Article.all.each do |article|
      article.author_name = article.author.name
      article.save
    end
    
    drop_table :authors
    
    remove_column :articles, :author_id
  end
end
