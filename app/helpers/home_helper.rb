module HomeHelper

	def find_gig_and_banners
		if params[:category_url].present?
			@gigs = []
			@category = Category.find_by_category_url(params[:category_url])
    		@subcategories = Category.where(title: @category.title)

    		@category_ids.each do |category_id| 
		      @gigs += Gig.where(:category_id=>category_id) if !Gig.where(:category_id=>category_id).blank?
		    end
		end
		@lists=[] 
	    @videos=[] 
	    @gigs.each do |gig|
	      if !gig.videos.first.nil?
	        @lists << gig.videos.first
	      else
	        @lists << gig.images.first
	      end
	    end
	    @lists = @lists.compact
	end
end
