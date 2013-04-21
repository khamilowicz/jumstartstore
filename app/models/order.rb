require 'active_model'
class Order

 include ActiveModel::Validations

 attr_accessor :products, :user
 attr_writer :address
 attr_reader :date_of_purchase

  validates_presence_of :products
  validates_presence_of :user

  def initialize products, user
    @products = products
    @user = user
    @date_of_purchase = Time.now
  end

  def address
    @address || @user.address 
  end

  def total_price
    @products.map(&:price).inject(:+)
  end
end