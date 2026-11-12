class CreateCarpets < ActiveRecord::Migration[8.1]
  def change
    create_table :carpets do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :stock

      t.timestamps
    end
  end
end
