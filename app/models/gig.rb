class Gig < ActiveRecord::Base
	belongs_to :user
	has_many :images, dependent: :destroy
	has_many :videos, dependent: :destroy
	has_many :ratings, dependent: :destroy
	has_many :transactions, dependent: :destroy
	has_many :extragigs, dependent: :destroy
	belongs_to :category
	belongs_to :sub_category
	has_many :reviews

	delegate :title, :subcategory_url, :to => :sub_category, :prefix => true
	delegate :name, :username, :location, :created_at, :avatar, :active, :to => :user, :prefix => true

	validates_presence_of :title, :sub_category_id

	acts_as_taggable 

	def average_rating
	  ratings.size.nonzero? ? (ratings.sum(:score) / ratings.size) : 0
	end

	def communication_average_rate
		@rating = ratings.where(rate_type: "communication")
		return @rating.size.nonzero? ? (@rating.sum(:score) / @rating.size) : 0
	end

	def service_average_rate
		@rating = ratings.where(rate_type: "service")
		return @rating.size.nonzero? ? (@rating.sum(:score) / @rating.size) : 0
	end

	def recommend_average_rate
		@rating = ratings.where(rate_type: "recommend")
		return @rating.size.nonzero? ? (@rating.sum(:score) / @rating.size) : 0
	end

end
