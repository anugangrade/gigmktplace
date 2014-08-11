class AddDeliveryWithinToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :delivery_within, :integer
  end
end
