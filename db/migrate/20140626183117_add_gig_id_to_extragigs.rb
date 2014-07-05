class AddGigIdToExtragigs < ActiveRecord::Migration
  def change
    add_column :extragigs, :gig_id, :integer
  end
end
