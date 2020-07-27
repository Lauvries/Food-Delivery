class Employee
  attr_reader :username, :password, :role
  attr_accessor :id

  def initialize(attributes = {})
    @username = attributes[:username]
    @role = attributes[:role]
    @password = attributes[:password]
    @id = attributes[:id]
  end

  def delivery_guy?
    @role == "delivery_guy"
  end

  def manager?
    @role == "manager"
  end
end

# employees = []
# john = Employee.new(username: 'John', role: 'delivery_guy', password: 'secret', id: '1')
# employees << john
# ringo = Employee.new(username: 'ringo', role: 'manager', password: 'secret', id: '2')
# employees << ringo
# george = Employee.new(username: 'george', role: 'manager', password: 'secret', id: '3')
# employees << george

# p employees.select { |employee| employee.role == 'manager' }
