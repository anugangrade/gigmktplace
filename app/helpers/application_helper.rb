module ApplicationHelper

	def all_categories
		return Category.all.collect {|a| [a.title]}.uniq.flatten
	end

	def flash_class(level)
	    case level
	        when :notice then "alert alert-info"
	        when :success then "alert alert-success"
	        when :error then "alert alert-error"
	        when :alert then "alert alert-error"
	    end
	end
	
end
