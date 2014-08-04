class AddIndexesToTables < ActiveRecord::Migration
  def change
  	add_index :attachments, :message_id
  	add_index :conversations, :user_id
  	add_index :extragigs, :gig_id
  	add_index :gigs, :category_id
  	add_index :gigs, :user_id
  	add_index :gigs, :sub_category_id
  	add_index :images, :gig_id
  	add_index :messages, :conversation_id
  	add_index :messages, :user_id
  	add_index :sub_categories, :category_id
  	add_index :transactions, :user_id
  	add_index :transactions, :gig_id
  	add_index :transactions, :extragig_id
  	add_index :videos, :gig_id
  end
end
