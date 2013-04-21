require 'active_model'
require_relative '../managers/paying_manager'
class Order

 include ActiveModel::Validations

 attr_accessor :products, :user
 attr_writer :address
 attr_reader :date_of_purchase, :status

  validates_presence_of :products
  validates_presence_of :user

  class << self
    @@all_orders = []
    def find_by_status stat
      @@all_orders.find_all{|order| order.status == stat.to_s}
    end
  end

  def initialize products, user
    @products = products
    @user = user
    @date_of_purchase = Time.now
    @status = 'pending'
    @@all_orders << self
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