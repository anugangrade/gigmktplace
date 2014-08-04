class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :gig_id
      t.integer :collection_id

      t.timestamps
    end
  end
end
