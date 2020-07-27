require 'pry-byebug'
require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @sessions_view = SessionsView.new
    @employee_repository = employee_repository
  end

  def sign_in
    # ask username
    username = @sessions_view.ask_user_for('Username')
    # ask password
    password = @sessions_view.ask_user_for('Password')
    # binding.pry
    # find_employee_by_username
    employee = @employee_repository.find_by_username(username)
    # see if it matches any && check if passwords match
    if employee && employee.password == password
      @sessions_view.message(employee.username)
      return employee
      # binding.pry
    else
      # if not - try again!
      @sessions_view.message(nil)
      sign_in
      # try again or signed in
    end

  end
end
