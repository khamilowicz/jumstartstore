class Cart

  def products
    @products||= []
  end

def purchase user 
  user.orders << Order.new(@products, user)
  @products = []
end

end