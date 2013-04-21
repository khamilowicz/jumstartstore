# require 'spec_helper'
require "rspec/autorun"
require "rspec/mocks"
require_relative '../../app/models/user.rb'
require_relative '../../app/models/order.rb'


describe User do
  before(:each) do
    @user = User.new
    @user.email = "John.Smith@gmail.co.uk"
    @user.first_name = "John"
    @user.last_name = "Smith"
  end
  context "to be valid" do

    context "must have email that is" do


      it "in email format" do
        @user.email = 'john.smith@gmail.co.uk'
        @user.should be_valid

        @user.email = 'shabada'
        @user.should_not be_valid
      end

      it "unique" do
        pending "delete after implementing database"
        user_2 = User.new 
        user_2.email = 'John.Smith@gmail.co.uk'
        user_2.first_name = 'John'
        user_2.last_name = 'Smith'
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
      @user.display_name.should == 'John Smith'
      @user.display_name = "Jonesey"
      @user.should be_valid
      @user.display_name = "J"
      @user.should_not be_valid
      @user.display_name = 'A'*33
      @user.should_not be_valid
    end
  end

  context "concerning products" do

    describe ".add_product" do
      before(:each) do
        @product = double("Product")
        @user.add_product @product 
      end

      it "adds product to user" do
        @user.products.should include(@product)
      end

      it "increases quantity of said product in user's products" do
        @user.product_quantity(@product).should == 1
        @user.add_product @product 
        @user.product_quantity(@product).should == 2
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
        @user.products.should include(@product_1, @product_2)
        @user.products.should_not include(@product_3)
      end
    end

    describe ".cart" do
      it "has only that user's products" do
        @user.cart.products.should include(@product_1, @product_2)
        @user.products.should_not include(@product_3)
      end
    end

    describe ".remove_product" do 
      it "removes product from users products" do 
        @user.remove_product @product_1
        @user.products.should_not include(@product_1)
        @user.products.should include(@product_2)
      end

      it "removes product form users cart" do
        @user.remove_product @product_1
        @user.cart.products.should_not include(@product_1)
        @user.cart.products.should include(@product_2)
      end
    end
  end

  context "concerning orders" do
    before(:each) do
     @product_1 = double("Product")
     @product_2 = double("Product")
     @product_3 = double("Product")
     @user.add_product @product_1
     @user.add_product @product_2
     @user.add_product @product_3
   end

   it "can purchase products from his cart" do
    @user.cart.products.should include(@product_1, @product_2, @product_3)
    @user.orders.should be_empty
    @user.make_purchase
    @user.cart.products.should be_empty
    @user.orders.should have(1).item
    @user.orders.first.should be_kind_of(Order)
  end
end
end
context "concerning status" do
  it "by default is guest" do
    @user.should be_guest
  end
end
end