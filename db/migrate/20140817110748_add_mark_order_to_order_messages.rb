class AddMarkOrderToOrderMessages < ActiveRecord::Migration
  def change
    add_column :order_messages, :mark_order, :string
  end
end
