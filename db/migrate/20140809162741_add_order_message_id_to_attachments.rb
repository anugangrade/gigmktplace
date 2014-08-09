class AddOrderMessageIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :order_message_id, :integer
  end
end
