class RenameClassesToOffers < ActiveRecord::Migration[7.1]
  def change
    rename_table :classes, :offers
  end
end
