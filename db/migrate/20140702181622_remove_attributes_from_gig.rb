class RemoveAttributesFromGig < ActiveRecord::Migration
  def change
  	remove_column :gigs, :rating_per_order
  	remove_column :gigs, :amount_per_gig
  	if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql"
  		change_column :gigs, :express_boolean, :boolean, default: 0
  	else
  		change_column :gigs, :express_boolean, 'boolean USING CAST(express_boolean AS boolean)', default: false
  	end
  	

  	remove_attachment :videos, :video
  end
end
