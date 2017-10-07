require_relative 'recipe'
require_relative 'cookbook'
require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end

  def create
    attributes = @view.ask_for_name_and_description
    recipe = Recipe.new(attributes)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    id = @view.ask_for_id('destroy')
    @cookbook.remove_recipe(id)
  end

  # method to delete all recipes
  def destroy_all
    @cookbook.destroy_all
    list
  end

  # method to copy recipies
  def copy
    # ask the user which recipe to copy
    id = @view.ask_for_id('copy')

    # get the recipe to be copied
    old_recipe = @cookbook.find(id)

    # build the new recipe with the information from the copied one
    new_recipe = Recipe.new(name: new_name, description: old_recipe.description)
    # insert into the cookbook
    @cookbook.add_recipe(new_recipe)
    # print the list
    list
  end

  def edit
    id = @view.ask_for_id('edit')
    old_recipe = @cookbook.find(id)
    new_attributes = @view.ask_for_name_and_description

    # edit the recipe name and description
    old_recipe.name = new_attributes[:name]
    old_recipe.description = new_attributes[:description]

    # It's not needed to update the array since by updating the object the array is also updated automatically
    # Since what is inside the array is a pointer to the object and not a copy of the object
    # remove it from the array
    # @cookbook.remove_recipe(id)
    # add the new version
    # @cookbook.add_recipe(old_recipe, id)

    @cookbook.save_to_csv

    # list
    list
  end
end
