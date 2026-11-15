class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :customer_name
      t.string :phone
      t.text :address
      t.decimal :total_price
      t.string :status

      t.timestamps
    end
  end
end
