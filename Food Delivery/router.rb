# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @orders_controller = orders_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
    @current_user = nil
  end

  def run
    @current_user = @sessions_controller.sign_in
    while @running
      if @current_user.role == 'manager'
        print_manager_menu
        choice = gets.chomp.to_i
        print `clear`
        route_action_manager(choice)
      else
        print_delivery_guy_menu
        choice = gets.chomp.to_i
        print `clear`
        route_action_delivery_guy(choice)
      end


    end
  end

  private

  def print_delivery_guy_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all of my orders"
    puts "2. Mark order as delivered"
    puts "8. Exit"
    print "> "
  end

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "5. Add order"
    puts "6. Lits all undelivered orders"
    puts "8. Exit"
    print "> "
  end

  def route_action_manager(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def route_action_delivery_guy(choice)
    current_user = @current_user
    case choice
    when 1 then @orders_controller.list_my_orders(current_user)
    when 2 then @orders_controller.mark_as_delivered(current_user)
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def stop!
    @running = false
  end
end
