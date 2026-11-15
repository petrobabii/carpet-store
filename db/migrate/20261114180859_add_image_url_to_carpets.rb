class AddImageUrlToCarpets < ActiveRecord::Migration[8.1]
  def change
    add_column :carpets, :image_url, :string
  end
end
