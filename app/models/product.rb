require "active_model"
require_relative "category"

class Product 

  include ActiveModel::Validations

  attr_accessor :title, :description, :price, :photo, :reviews

  validates_presence_of :title
  validates_presence_of :description
  validates_format_of :price, with: /\A[^-]\d+\.\d{2}\Z/
  validates_format_of :photo, with: /\A(http|https):\/\/(www\.)?\w+\.\w+\/\w+\Z/, allow_blank: true


class << self
  @@all_products = []
  def find_on_sale
    @@all_products.find_all{|product| product.on_sale?}
  end
end

  def initialize 
    @on_sale = false
    @@all_products << self
  end

  def add_to_category category 
   Category.get(category).add_product self
 end

 def add_review review
  reviews << review
end

def rating
  return 0 if reviews.empty?
  average = reviews.map(&:note).inject(:+).to_f/reviews.size
  (2.0*average).round/2.0 # round to 0.5
end

def reviews
  @reviews ||= []
end

def list_categories
  Category.names_for_product(self)
end

def on_sale?
  @on_sale
  end

  def start_selling
    @on_sale = true
  end

  def retire
    @on_sale = false
    
  end
end