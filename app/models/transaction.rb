class Transaction < ActiveRecord::Base
	belongs_to :user
	belongs_to :gig

	serialize :extragigs_quatity_id, :if=> :mysql?
	has_one :order_conversation

	def mysql?
		ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql2"
	end
end
