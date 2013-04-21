require_relative "../../app/models/category"
require_relative "../../app/models/product"
require "rspec/autorun"
require "rspec/mocks"

describe Category do

  describe "class.list_categories" do
    it "lists all categories" do
      c1 = Category.get("C_1")
      c2 = Category.get("C_2")
      c3 = Category.get("C_3")
      Category.list_categories.should include(c1)
      Category.list_categories.should include(c2)
      Category.list_categories.should include(c3)
    end
  end

  it "has unique name" do
    category_1 = Category.get("Category_1")
    category_2 = Category.get("Category_1")
    category_1.should be(category_2)
    Category.list_categories.should have(1).item
  end

  it "can have associated products" do
    c1 = Category.get("Category_1")
    product = double("Product")
    product.stub(:on_sale?).and_return(true)
    c1.add_product product
    c1.products.should include(product)
  end

  it "finds products by category" do
    product_1 = Product.new
    product_2 = Product.new
    product_3 = Product.new
    product_1.add_to_category "Category_1"
    product_2.add_to_category "Category_1"
    product_3.add_to_category "Category_2"

    products_c_1 = Category.find_products_for("Category_1")
    
    products_c_1.should include(product_1,product_2)
    products_c_1.should_not include(product_3)
    Category.find_products_for("Category_2").should include(product_3)
  end

  it "can be put on sale" do
    product_1 = Product.new
    product_2 = Product.new
    product_3 = Product.new
    product_1.add_to_category "Category_11"
    product_2.add_to_category "Category_11"
    product_3.add_to_category "Category_2"
    
    category = Category.get "Category_11"
    category.all_on_sale?.should be_false
    category.put_on_sale
    category.all_on_sale?.should be_true
  end

end