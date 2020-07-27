require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(file_path)
    @meals = []
    @file_path = file_path
    @next_id = 1
    load_csv if File.exist?(@file_path)
  end

  def add(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  private

  def load_csv
    @next_id = 0
    csv_options = { headers: :first_row, header_converters: :symbol }
    # if File.exist?(@file_path)
    CSV.foreach(@file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_f
      @meals << Meal.new(row)
      @next_id = row[:id]
    end
    # end
    @next_id += 1
  end

  def save_csv
    CSV.open(@file_path, "wb") do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
