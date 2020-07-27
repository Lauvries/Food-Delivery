require_relative '../models/employee'

class EmployeeRepository
  def initialize(file_path)
    @file_path = file_path
    @employees = []
    load_csv if File.exist? @file_path
  end

  # all
  def all
    @employees.all
  end

  # find_by_id
  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  # find_by_username
  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  def all_delivery_guys
    @employees.select { |employee| employee.role == 'delivery_guy' }
  end

  # load csv
  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end
