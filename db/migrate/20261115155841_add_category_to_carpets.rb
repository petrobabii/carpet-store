class AddCategoryToCarpets < ActiveRecord::Migration[8.1]
  def change
    add_column :carpets, :category, :string
  end
end
