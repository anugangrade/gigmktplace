class ModifyFieldsInTransactions < ActiveRecord::Migration
  def change
  	rename_column :transactions, :amount, :extragig_id
  	rename_column :transactions, :currency, :quantity
  	change_column :transactions, :quantity, :integer
  end
end
