# require 'spec_helper'
require "rspec/autorun"
require "rspec/mocks"
require_relative '../../app/models/user.rb'

describe User do
	context "to be valid" do
    before(:each) do
      @user = User.new
      @user.email = "John.Smith@gmail.co.uk"
      @user.first_name = "John"
      @user.last_name = "Smith"
    end

    context "must have email that is" do


      it "in email format" do
        @user.email = 'john.smith@gmail.co.uk'
        @user.should be_valid

        @user.email = 'shabada'
        @user.should_not be_valid
      end

      it "unique" do
        pending 'release after adding database'
        user_2 = User.new 
        user_2.email = 'john.smith@gmail.co.uk'
        user_2.should_not be_valid
      end
    end

    it "A user must have a full name that is not blank" do
      @user.should be_valid
      @user.first_name = ''
      @user.should_not be_valid
      @user.first_name = 'John'
      @user.last_name = ''
      @user.should_not be_valid
      @user.last_name = "Smith"
      @user.full_name.should == 'John Smith'
    end
    

    it "A user may optionally provide a display name that must be no less than 2 characters long and no more than 32" do
      @user.display_name = "Jonesey"
      @user.should be_valid
      @user.display_name = "J"
      @user.should_not be_valid
      @user.display_name = 'A'*33
      @user.should_not be_valid
    end
  end

  context "concerning products" do
    before(:each) do
      @user = User.new
    end

    describe ".add_product" do
      it "adds valid product to user" do
        product = double("Product")
        @user.add_product product 
        @user.products.should include(product)
      end

      it "lets save user with product" do
      end
    end

    context "which he has" do
      before(:each) do

        @product_1 = double("Product")
        @product_2 = double("Product")
        @product_3 = double("Product")
        @user.add_product @product_1
        @user.add_product @product_2
      end



      describe ".products" do
        it "is list of user proudcts" do
          @user.products.should include(@product_1)
          @user.products.should include(@product_2)
          @user.products.should_not include(@product_3)
        end
      end

      describe ".cart" do
        it "has only that user's products" do
          @user.cart.products.should include(@product_1)
          @user.cart.products.should include(@product_2)
          @user.products.should_not include(@product_3)
        end
      end
    end
  end

end
