class Gig < ActiveRecord::Base
	belongs_to :user
	has_many :images, dependent: :destroy
	has_many :videos, dependent: :destroy
	has_many :ratings, dependent: :destroy
	has_many :transactions
	has_many :extragigs
	belongs_to :category

	validates_presence_of :title, :category_id

	acts_as_taggable 

	def average_rating
	  ratings.size.nonzero? ? (ratings.sum(:score) / ratings.size) : 0
	end

end
