class RenameAmountPerExtragigToAmountInExtragig < ActiveRecord::Migration
  def change
  	rename_column :extragigs, :amount_per_extragig, :amount
  	change_column :extragigs, :amount, 'integer USING CAST(amount AS integer)'
  end
end
