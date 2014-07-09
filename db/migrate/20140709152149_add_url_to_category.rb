class AddUrlToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :category_url, :string
    add_column :categories, :subcategory_url, :string
  end
end
