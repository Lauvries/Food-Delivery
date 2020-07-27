require_relative '../views/meals_view'
require_relative '../models/meal'

# require_relative '../repositories/meal_repository'


class MealsController
  def initialize(meal_repository)
    @view = MealsView.new
    @meal_repository = meal_repository
  end

  def add
    name = @view.ask_user_for("name")
    price = @view.ask_user_for("price")
    @meal_repository.add(Meal.new(name: name, price: price))
  end

  def list
    @view.list(@meal_repository.all)
  end
end
