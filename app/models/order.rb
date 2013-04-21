require 'active_model'
require_relative '../managers/paying_manager'
class Order

 include ActiveModel::Validations

 attr_accessor :products, :user
 attr_writer :address
 attr_reader :date_of_purchase, :status

  validates_presence_of :products
  validates_presence_of :user

  def initialize products, user
    @products = products
    @user = user
    @date_of_purchase = Time.now
    @status = 'pending'
  end

  def address
    @address || @user.address 
  end

  def total_price
    @products.map(&:price).inject(:+)
  end

  def cancel
    @status = "cancelled"
  end

  def pay
    @status = "paid" if PayingManager.pay(@order, @user).is_paid?
  end

  def is_sent
    @status = "shipped"
  end

  def is_returned
    @status = "returned"
  end
end