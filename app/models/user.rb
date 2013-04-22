require "active_model"
require_relative 'cart'

class User 

  include ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :email, :first_name, :last_name, :display_name, :logged
  attr_reader :admin
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
 # validates_uniqueness_of :email
 validates_presence_of :first_name
 validates_presence_of :last_name
 validates :display_name, length: {minimum: 2, maximum: 32}, allow_blank: true

 def initialize attributes={}

  @email = attributes[:email]
  @first_name = attributes[:first_name]
  @last_name = attributes[:last_name]
  @display_name = attributes[:display_name]

  # attributes.each{|k,v| instance_eval "@#{k}='#{v}'"}
  @logged = false
  @admin = false
end

def full_name
  "#{first_name} #{last_name}"
end

def add_product product 
  products << product if product.on_sale?
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

def display_name
  @display_name || self.full_name
end

def guest?
  not @logged
end 

def admin?
  admin
end

def promote_to_admin user_promoting
  @admin = true if user_promoting.admin?
end
end