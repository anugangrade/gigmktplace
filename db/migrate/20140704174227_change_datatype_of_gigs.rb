class ChangeDatatypeOfGigs < ActiveRecord::Migration
  def change
  	change_column :gigs, :title, :text
  	change_column :gigs, :description, :text
  	change_column :gigs, :instructions_for_buyer, :text
  end
end
