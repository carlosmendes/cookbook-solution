require 'csv'
require_relative 'recipe'

class Cookbook # Repository, Fake Database
  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    load_csv
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index] # returns an instance / object of Recipe
  end

  def add_recipe(recipe, index = nil)
    if index
      @recipes.insert(index, recipe)
    else
      @recipes << recipe
    end
    save_to_csv
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id)
    save_to_csv
  end

  def destroy_all
    @recipes = []
    save_to_csv
  end


  def save_to_csv
    CSV.open(@csv_file, 'w') do |csv|
      @recipes.each do |recipe|
        csv.puts([recipe.name, recipe.description])
      end
    end
  end

  private

  def load_csv
    return unless File.exist?(@csv_file)

    CSV.foreach(@csv_file) do |row|
      attributes = {
        name: row[0],
        description: row[1]
      }
      @recipes << Recipe.new(attributes)
    end
  end
end
