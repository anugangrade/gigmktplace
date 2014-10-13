class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :gig_id

      t.timestamps
    end
  end
end
