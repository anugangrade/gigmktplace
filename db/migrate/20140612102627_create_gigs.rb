class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.string :title
      t.string :category_id
      t.integer :subcategory_id
      t.integer :user_id
      t.string :description
      t.string :instructions_for_buyer
      t.string :tags
      t.string :rating_per_order
      t.string :express_boolean
      t.string :amount_per_gig

      t.timestamps
    end
  end
end
