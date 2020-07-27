class CustomersView
  def ask_user_for(stuff)
    puts stuff.to_s
    gets.chomp
  end

  def list(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1}) #{customer.name}, #{customer.address}"
    end
  end
end
