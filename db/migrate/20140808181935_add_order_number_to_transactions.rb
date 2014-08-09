class AddOrderNumberToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :order_number, :string
    add_column :transactions, :order_status, :string
  end
end
