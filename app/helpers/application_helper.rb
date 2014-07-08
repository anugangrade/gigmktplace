module ApplicationHelper

	def flash_class(level)
	    case level
	        when 'notice' then "alert alert-info"
	        when 'success' then "alert alert-success"
	        when 'error' then "alert alert-danger"
	        when 'alert' then "alert alert-danger"
	    end
	end

	def all_categories
		return Category.all.collect {|a| [a.title]}.uniq.flatten
	end

	
end
