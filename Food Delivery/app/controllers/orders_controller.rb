
require_relative "../views/meals_view"
require_relative "../views/customers_view"
require_relative "../views/sessions_view"
require_relative "../views/orders_view"


class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meal_view = MealsView.new
    @sessions_view = SessionsView.new
    @customers_view = CustomersView.new
  end

  def add
    # need to Order.new():
    @meal_view.list(@meal_repository.all)
    meal_index = @orders_view.ask_user_for("Meal index")
    meal = @meal_repository.find(meal_index)

    @sessions_view.display(@employee_repository.all_delivery_guys)
    employee_index = @orders_view.ask_user_for("Employee index")
    employee = @employee_repository.find(employee_index)

    @customers_view.list(@customer_repository.all)
    customer_index = @orders_view.ask_user_for("Customer index")
    customer = @customer_repository.find(customer_index)

    @order_repository.add(Order.new(meal: meal, employee: employee, customer: customer))
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @orders_view.display(undelivered_orders)
  end

  def list_my_orders(employee)
    id = employee.id
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders.select { |order| order.employee.id == id })
  end

  def mark_as_delivered(employee)
    id = employee.id
    orders = @order_repository.undelivered_orders
    undelivered_order = orders.find { |order| order.employee.id == id }
    @order_repository.deliver!(undelivered_order)
  end
end
