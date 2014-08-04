class SubCategory < ActiveRecord::Base
	belongs_to :category
	has_many :gigs

	delegate :title, :category_url, :to => :category, :prefix => true
end
