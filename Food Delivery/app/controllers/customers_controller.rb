require_relative '../views/customers_view'
require_relative '../models/customer'
# require_relative '../repositories/customer_repository'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def add
    name = @view.ask_user_for("Name")
    address = @view.ask_user_for("Address")
    @customer_repository.add(Customer.new(name: name, address: address))
  end

  def list
    @view.list(@customer_repository.all)
  end
end
