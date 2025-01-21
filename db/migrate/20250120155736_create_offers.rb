class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :address
      t.date :date
      t.time :time
      t.integer :capacity

      t.timestamps
    end
  end
end
