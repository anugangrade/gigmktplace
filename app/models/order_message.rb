class OrderMessage < ActiveRecord::Base
	belongs_to :order_conversation
	belongs_to :user

	delegate :name, :username, :location, :created_at, :avatar, :active, :to => :user, :prefix => true

end
