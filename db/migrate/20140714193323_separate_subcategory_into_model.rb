class SeparateSubcategoryIntoModel < ActiveRecord::Migration
  def change
  	add_column :gigs, :sub_category_id, :integer
  	remove_column :categories, :subtitle
  	remove_column :categories, :subcategory_url
  end
end
