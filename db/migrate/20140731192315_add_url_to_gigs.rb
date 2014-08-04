class AddUrlToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :url, :string
  end
end
