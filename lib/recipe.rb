class Recipe
  attr_accessor :name, :description

  def initialize(attributes)
    @name = attributes[:name]
    @description = attributes[:description]
  end
end
