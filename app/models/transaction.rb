class Transaction < ActiveRecord::Base
	belongs_to :user
	belongs_to :gig

	has_one :order_conversation

end
