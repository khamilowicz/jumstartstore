class Sale
  class << self
    @@all_sales = {}

def set_discount product, disc
  @@all_sales[product] = disc.to_f/100.0
  
end

def discount_price product
  product.real_price * discount(product)
end


def list_sales
  @@all_sales.map{|k,v| [k, v*=100.round]}
end

def get_discount product
  discount product
  
end
private 
def discount product
  @@all_sales[product]
end
end
end