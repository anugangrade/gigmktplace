module ApplicationHelper

	def all_categories
		return Category.all.collect {|a| [a.title]}.uniq.flatten
	end
	
end
