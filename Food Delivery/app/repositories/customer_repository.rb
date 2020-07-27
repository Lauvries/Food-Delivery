class CustomerRepository
  def initialize(file_path)
    @customers = []
    @file_path = file_path
    @next_id = 1
    load_csv if File.exist? @file_path
  end

  def all
    @customers
  end

  def add(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  private

  def load_csv
    @next_id = 0
    csv_options = { headers: :first_row, header_converters: :symbol }
    # if File.exist?(@file_path)
    CSV.foreach(@file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
      @next_id = row[:id]
    end
    # end
    @next_id += 1
  end

  def save_csv
    CSV.open(@file_path, "wb") do |csv|
      csv << ['id', 'name', 'address']
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
