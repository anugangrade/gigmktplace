class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :gig
	has_many :replies
end
