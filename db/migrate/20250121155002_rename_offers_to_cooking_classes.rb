class RenameOffersToCookingClasses < ActiveRecord::Migration[7.1]
  def change
    rename_table :offers, :cooking_classes
  end
end
