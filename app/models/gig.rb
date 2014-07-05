class Gig < ActiveRecord::Base
	belongs_to :user
	has_many :images, dependent: :destroy
	has_many :videos, dependent: :destroy
	has_many :ratings, dependent: :destroy
	has_many :transactions
	has_many :extragigs

	acts_as_taggable 

	def average_rating
	  ratings.size.nonzero? ? (ratings.sum(:score) / ratings.size) : 0
	end

end
