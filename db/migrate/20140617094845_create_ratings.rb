class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :gig, index: true
      t.references :user, index: true
      t.integer :score
      t.string :default
      # t.string :0

      t.timestamps
    end
  end
end
