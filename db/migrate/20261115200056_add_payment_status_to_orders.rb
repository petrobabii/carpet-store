class AddPaymentStatusToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :payment_status, :string
  end
end
