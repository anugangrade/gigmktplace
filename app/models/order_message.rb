class OrderMessage < ActiveRecord::Base
	belongs_to :order_conversation
	belongs_to :user

	has_many :attachments
	accepts_nested_attributes_for :attachments, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true

	delegate :name, :username, :location, :created_at, :avatar, :active, :to => :user, :prefix => true

end
