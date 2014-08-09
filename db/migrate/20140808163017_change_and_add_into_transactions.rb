class ChangeAndAddIntoTransactions < ActiveRecord::Migration
  def change
  	remove_column :transactions, :extragig_id, :integer
  	add_column :transactions, :extragig_ids, :string, array: true, default: '{}'
  	rename_column :transactions, :quantity, :gig_quantity
  	add_column :transactions, :total_amount, :integer
  	add_column :transactions, :extragigs_quatity_id, :string, array: true, default: '{}'
  end
end
