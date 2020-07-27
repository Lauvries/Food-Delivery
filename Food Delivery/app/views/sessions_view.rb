class SessionsView
  def ask_user_for(stuff)
    puts "#{stuff}:"
    print "> "
    gets.chomp
  end

  def message(message)
    puts message.class == String ? "Welcome #{message}" : "Wrong credentials"
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end
end
