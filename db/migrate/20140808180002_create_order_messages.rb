class CreateOrderMessages < ActiveRecord::Migration
  def change
    create_table :order_messages do |t|
      t.integer :order_conversation_id
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
