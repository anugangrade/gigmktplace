class OrderConversation < ActiveRecord::Base
	has_many :order_messages
	belongs_to :user

	belongs_to :order_transaction, class_name: "Transaction"
end
