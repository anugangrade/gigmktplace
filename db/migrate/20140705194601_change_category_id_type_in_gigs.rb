class ChangeCategoryIdTypeInGigs < ActiveRecord::Migration
  def change
  	if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql2"
  		change_column :gigs, :category_id, :integer
  	else
  		change_column :gigs, :category_id, 'integer USING CAST(category_id AS integer)'
  	end
  end
end
