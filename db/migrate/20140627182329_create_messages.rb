class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
