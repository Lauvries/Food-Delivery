require_relative "./sessions_view"

class OrdersView
  def ask_user_for(stuff)
    puts stuff.to_s
    a = gets.chomp
    a.to_i
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index}) #{order.customer.name},
       #{order.customer.address},
       #{order.meal.name},
       #{order.employee.username}"
    end
  end
end
