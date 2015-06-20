class AddSubtotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :subtotal, :integer
  end
end
