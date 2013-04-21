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
end
end
