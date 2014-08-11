class Transaction < ActiveRecord::Base
	belongs_to :user
	belongs_to :gig

	serialize(:extragigs_quatity_id, Array)

	has_one :order_conversation

end
