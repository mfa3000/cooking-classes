class RenameOffersToClasses < ActiveRecord::Migration[7.1]
  def change
    rename_table :offers, :classes
  end
end
