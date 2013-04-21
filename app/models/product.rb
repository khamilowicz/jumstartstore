require "active_model"

class Product 
  
  include ActiveModel::Validations

  attr_accessor :title, :description, :price, :photo

  validates_presence_of :title
  validates_presence_of :description
  validates_format_of :price, with: /\A[^-]\d+\.\d{2}\Z/
  validates_format_of :photo, with: /\A(http|https):\/\/(www\.)?\w+\.\w+\/\w+\Z/, allow_blank: true
end