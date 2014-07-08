class Conversation < ActiveRecord::Base
	belongs_to :user
	has_many :messages

	def self.find_conversation(receiver, sender)
		receiver_convs = self.where("user_id = ? OR sender_id = ?", receiver.id, receiver.id)
		if !receiver_convs.blank? 
			receiver_convs.each do |receiver_conv|
				if receiver_conv.user_id == receiver.id && receiver_conv.sender_id == sender.id
					return receiver_conv
				elsif receiver_conv.sender_id == receiver.id && receiver_conv.user_id == sender.id
					return receiver_conv
				else
					return nil
				end
			end
		else
			return nil
		end
	end
end
