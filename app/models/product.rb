require "active_model"

class Product 
  
  include ActiveModel::Validations

  attr_accessor :title

  validates_presence_of :title
end