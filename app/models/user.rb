require "active_model"
require_relative 'cart'

class User 

  include ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :email, :first_name, :last_name, :display_name

 validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :display_name, length: {minimum: 2, maximum: 32}, allow_blank: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def add_product product 
    products << product
  end

  def products
    cart.products
  end

  def remove_product product
    products.delete(product)
  end

  def cart
    @cart ||= Cart.new
  end

  def product_quantity product
    products.count{|x| x == product}
  end

  def make_purchase
    cart.purchase self
  end

  def orders
    @orders ||= []
  end
  
  end