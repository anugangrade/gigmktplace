class RenameAmountPerExtragigToAmountInExtragig < ActiveRecord::Migration
  def change
  	rename_column :extragigs, :amount_per_extragig, :amount
  	if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql2"
  		change_column :extragigs, :amount, :integer
  	else
  		change_column :extragigs, :amount, 'integer USING CAST(amount AS integer)'
  	end
  end
end
