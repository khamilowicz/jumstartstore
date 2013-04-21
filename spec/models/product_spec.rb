# require 'spec_helper'
require_relative '../../app/models/product'
require 'rspec/autorun'

describe Product do

	context "to be valid" do
    before(:each) do
      @product = Product.new
    end
    
    it "A product must have a title, description, and price." do
      @product.title = ''
      @product.should_not be_valid
    end
    
    
    it "The title and description cannot be empty strings."
    it "The title must be unique for all products in the system"
    it "The price must be a valid decimal numeric value and greater than zero"
    it "The photo is optional. If present it must be a valid URL format."
  end
end
