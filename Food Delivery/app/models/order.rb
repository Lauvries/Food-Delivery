class Order
  attr_reader :meal, :customer, :delivered
  attr_accessor :id

  def initialize(attributes = {})
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @id = attributes[:id]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

  def employee
    @employee
  end
end
