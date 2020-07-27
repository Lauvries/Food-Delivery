require_relative "../models/order"

class OrderRepository
  def initialize(file_path, meal_repository, customer_repository, employee_repository)
    @file_path = file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@file_path)
  end

  def add(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def deliver!(order)
    order.deliver!
    save_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def load_csv
    @next_id = 0
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      @orders << Order.new(row)
      @next_id = row[:id]
    end
    @next_id += 1
  end

  def save_csv
    CSV.open(@file_path, 'wb') do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered?']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end
