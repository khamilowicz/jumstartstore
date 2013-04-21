# require 'spec_helper'
require "rspec/autorun"
require_relative '../../app/models/order'
require "rspec/mocks"

describe Order do
  context "to be valid" do
    before(:each) do
      @user = double("User")
      @user.stub(:address).and_return("Address")
      @product_1 = double("Product")
      @product_2 = double("Product")
      @product_3 = double("Product")
      @products = [@product_1, @product_2, @product_3]
    end

    it "must belong to an user" do
      expect{order = Order.new}.to raise_error
      user = double("User")
      expect{order = Order.new(@products, @user )}.not_to raise_error
    end
    

    it "is for one or more products currently being sold" do
      order = Order.new([], @user)
      expect(order).not_to be_valid 
      order = Order.new(@products, @user)
      order.should be_valid
    end

    it "has address" do
      order = Order.new(@products, @user)
      order.address.should == 'Address'
      order.address = "Other address"
      order.address.should == 'Other address'
    end


  end
end

