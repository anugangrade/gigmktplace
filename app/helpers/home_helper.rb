module HomeHelper

	def find_gig_and_banners
		if params[:category_url].present?
			@category = Category.find_by_category_url(params[:category_url])
    		@subcategories = @category.sub_categories
    		@subcategory = SubCategory.find_by_subcategory_url(params[:subcategory_url]) if params[:subcategory_url].present?
    		@gigs =  params[:subcategory_url].present? ? Gig.where(:sub_category_id=>@subcategory) : Gig.where(:category_id=>@category)	    
		end
	end
end
