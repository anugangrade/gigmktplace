class RemoveAttributesFromGig < ActiveRecord::Migration
  def change
  	remove_column :gigs, :rating_per_order
  	remove_column :gigs, :amount_per_gig
  	change_column :gigs, :express_boolean, :boolean, default: 0

  	remove_attachment :videos, :video
  end
end
