class CreateOrderConversations < ActiveRecord::Migration
  def change
    create_table :order_conversations do |t|
      t.integer :user_id
      t.integer :sender_id
      t.integer :transaction_id

      t.timestamps
    end
  end
end
