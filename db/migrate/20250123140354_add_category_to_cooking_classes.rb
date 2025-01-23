class AddCategoryToCookingClasses < ActiveRecord::Migration[7.1]
  def change
    add_column :cooking_classes, :category, :string
  end
end
