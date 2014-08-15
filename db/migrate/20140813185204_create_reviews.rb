class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :gig_id
      t.integer :user_id
      t.text :content
      t.boolean :like_it

      t.timestamps
    end
  end
end
