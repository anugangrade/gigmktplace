class ModifyFieldsInTransactions < ActiveRecord::Migration
  def change
  	rename_column :transactions, :amount, :extragig_id
  	rename_column :transactions, :currency, :quantity
  	if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql"
  		change_column :transactions, :quantity, :integer
  	else
  		change_column :transactions, :quantity, 'integer USING CAST(quantity AS integer)'
  	end
  end
end
