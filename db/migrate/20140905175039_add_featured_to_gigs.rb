class AddFeaturedToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :featured, :boolean, default: 0
  end
end
