class AddTypeToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :rate_type, :string
  end
end
