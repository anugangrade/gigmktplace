module UsersHelper
	def find_receiver(conversation)
		conversation.user_id == current_user.id ? User.find(conversation.sender_id) : User.find(conversation.user_id)
	end
end