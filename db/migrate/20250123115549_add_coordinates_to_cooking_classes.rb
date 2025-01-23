class AddCoordinatesToCookingClasses < ActiveRecord::Migration[7.1]
  def change
    add_column :cooking_classes, :latitude, :float
    add_column :cooking_classes, :longitude, :float
  end
end
