class Category < ActiveRecord::Base
	has_one :gig
	has_many :sub_categories
end
