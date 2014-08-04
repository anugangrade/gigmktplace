class Bookmark < ActiveRecord::Base
	belongs_to :user
	belongs_to :gig
	belongs_to :collection
end
