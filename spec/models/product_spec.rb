# require 'spec_helper'
require_relative '../../app/models/product'
require 'rspec/autorun'

describe Product do

	context "to be valid" do
    before(:each) do
      @product = Product.new
      @product.price = '19.43'
      @product.description = 'Product description'
      @product.title = 'Product title'
    end

    context "A product must have" do 

      it "a title" do
        @product.title = ''
        @product.should_not be_valid
        @product.title = 'Product title'
        @product.should be_valid
      end

      it "description" do 
       @product.description = ''
       @product.should_not be_valid
       @product.description = 'Product description'
       @product.should be_valid
     end

     it "price" do
      @product.should_not be_nil
    end


    it "The title must be unique for all products in the system" do
     pending 'after implementing db' 
   end


   it "The price must be a valid decimal numeric value and greater than zero" do
     @product.price = ''
     @product.should_not be_valid
     @product.price = 'shabada'
     @product.should_not be_valid
     @product.price = '19'
     @product.should_not be_valid
     @product.price = '19.432'
     @product.should_not be_valid
     @product.price = -10.01
     @product.should_not be_valid
     @product.price = '19.43'
     @product.should be_valid
   end

   it "The photo is optional. If present it must be a valid URL format." do
     @product.photo.should be_nil 
     @product.should be_valid
     @product.photo = 'shabada'
     @product.should_not be_valid
     @product.photo = 'http://google.pl/image'
     @product.should be_valid
   end
 end

 context "concerning categories" do
  describe ".add_to_category" do
    it "can take category name" do
      @product.add_to_category "Category_1"
      @product.list_categories.should include("Category_1")
    end

    it "can take category object" do 
      category = double("Category")
      category.stub(:name).and_return("Category_1")
      category.stub(:class).and_return(Category)
      @product.add_to_category category
      @product.list_categories.should include("Category_1")
    end
  end

  describe ".list_categories" do
    it "gets only names of categories the product belongs to" do
      @product.add_to_category "Category_1"
      category_2 = Category.get "Category_2"
      @product.list_categories.should include("Category_1")
      @product.list_categories.should_not include("Category_2")
    end
  end

end

context "concerning reviews" do
  describe "reviews" do
    before(:each) do
      @review_1 = double("Review")
      @review_1.stub(:note).and_return(5)
      @review_2 = double("Review")
      @review_2.stub(:note).and_return(1)
    end
    it "has reviews" do
     @product.add_review @review_1
     @product.reviews.should include(@review_1)
   end

   it "has raiting, based on reviews" do
    @product.rating.should == 0

    @product.add_review @review_1
    @product.rating.should == 5

    @product.add_review @review_2
    @product.rating.should == 3
  end

  it "rating can only by integer or half" do
   @product.add_review @review_1
   @product.add_review @review_1
   @product.add_review @review_2
   @product.rating.should == 3.5
 end
end

describe ".on_sale" do
  it "by default is not on sale" do
    @product.should_not be_on_sale
  end

  it "can be set to sold" do
    @product.start_selling
    @product.should be_on_sale
  end

  it "can be retired from selling" do
    @product.start_selling
    @product.retire
    @product.should_not be_on_sale
  end

  it "can be found be sale status" do
    Product.find_on_sale.should_not include(@product)
    @product.start_selling
    Product.find_on_sale.should include(@product)
  end
end
end
end
end