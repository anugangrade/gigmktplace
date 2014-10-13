class AddFeaturedToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :featured, :boolean, default: false
  end
end
