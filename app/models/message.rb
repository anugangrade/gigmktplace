class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversation
	has_many :attachments
end
