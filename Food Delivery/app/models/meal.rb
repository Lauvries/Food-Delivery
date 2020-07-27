class Meal
  attr_reader :name, :price
  attr_accessor :id

  def initialize(attributes = {})
    @name = attributes[:name]
    @price = attributes[:price].to_i
    @id = attributes[:id]
  end
end

# p meal = Meal.new(name: "Curry", price: "2.50")
# p meal.price.to_f
