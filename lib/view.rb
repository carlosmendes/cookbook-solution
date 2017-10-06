class View
  def display_recipes(recipes)
    puts "These are your recipes (#{recipes.length}):"
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name} - #{recipe.description}"
    end
  end

  def ask_for_name_and_description
    attributes = {}
    puts "What's the recipe name?"
    print "> "
    attributes[:name] = gets.chomp
    puts "Please describe your recipe"
    print "> "
    attributes[:description] = gets.chomp
    return attributes
  end

  def ask_for_id(action)
    puts "What's the recipe index you want to #{action}?"
    index = gets.chomp.to_i - 1
    return index
  end

end
