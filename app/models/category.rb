class Category

  @@all_categories = []

  class << self
   def get categ
    name = categ.respond_to?(:name) ? categ.name : categ
    @@all_categories.find{|category| category.name == name} || Category.new(name)
  end

  def names_for_product product
    @@all_categories.find_all{|category| category.products.include?(product)}.map(&:name)
  end

  def find_products_for cat 
    Category.get(cat).products
  end

  def list_categories
    @@all_categories
  end
end

attr_accessor :name, :products

def initialize name
  @name = name
  @@all_categories << self
  @products = []
end

def add_product product
  products << product
end

def all_on_sale?
  products.all?{|product| product.on_sale?}
end

def put_on_sale
  products.each{|product| product.start_selling}
end


end