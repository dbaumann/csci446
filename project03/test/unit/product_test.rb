require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  #not necessary in this case, but important to note
  fixtures :products
  
  def setup
    @product = Product.new(:title       => "My book title",
                          :description  =>  "yyy",
                          :image_url    =>  "zzz.jpg",
                          :price        =>  1)
  end
  
  test "invalid with empty attributes" do
    empty_product = Product.new
    
    #first pass
    assert !empty_product.valid?
    
    #test individual fields
    assert empty_product.errors.invalid?(:title)
    assert empty_product.errors.invalid?(:description)
    assert empty_product.errors.invalid?(:image_url)
    assert empty_product.errors.invalid?(:price)
    
  end
  
  test "positive price" do
      
    #verify a few failures before checking for a success
    @product.price = -1
    assert !@product.valid?
    #also make sure that the error has the correct error message associated with it:
    assert_equal "should be atleast 0.01", @product.errors.on(:price)
    
    @product.price = 0
    assert !@product.valid?
    assert_equal "should be atleast 0.01", @product.errors.on(:price)
    
    
    @product.price = 1
    assert @product.valid?
  end
  
  
  test "image url" do
    #an array literal specifying some good inputs
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    #check the good inputs one at a time
    ok.each do |name|
      product = Product.new(:title       => "My Book Title",
                    :description => "yyy",
                    :price       => 1,
                    :image_url   => name)
      assert product.valid?, product.errors.full_messages
    end

    bad.each do |name|
      product = Product.new(:title       => "My Book Title",
                    :description => "yyy",
                    :price       => 1,
                    :image_url   => name)
      assert !product.valid?, "saving #{name}"
    end
  end
  
  test "unique title" do               #model_name(fixture_name)
    duplicate_product = Product.new(:title        =>  products(:ruby_book).title,
                                    :description  =>  "yyy",
                                    :price        =>  1,
                                    :image_url    =>  "fred.gif")
    #model has been created in memory, but the uniqueness validation doesn't
    #occur until we attempt to persist the model (can't use valid? for this one)
    
    assert !duplicate_product.save
    assert_equal  "has already been taken", duplicate_product.errors.on(:title)
    
  end
  
end
