require 'active_model'
class Order

 include ActiveModel::Validations

 attr_accessor :products, :user
 attr_writer :address

  validates_presence_of :products
  validates_presence_of :user

  def initialize products, user
    @products = products
    @user = user
  end

  def address
    @address || @user.address 
  end
end