class RemovesubcategoryIdFromGig < ActiveRecord::Migration
  def change
  	remove_column :gigs, :subcategory_id
  end
end
