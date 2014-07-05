class RenameAmountPerExtragigToAmountInExtragig < ActiveRecord::Migration
  def change
  	rename_column :extragigs, :amount_per_extragig, :amount
  	change_column :extragigs, :amount, 'integer USING CAST(column_to_change AS integer)'
  end
end
