class HomeController < ApplicationController

  def index 
  	if params[:search_by]
      if params[:search_by].to_i.zero?
        @gigs = []
        @category_ids = Category.where(title: params[:search_by]).collect(&:id)
        @category_ids.each do |category_id| 
          @gigs += Gig.where(:category_id=>category_id) if !Gig.where(:category_id=>category_id).blank?
        end
      else
  		  @gigs=Gig.where(:category_id=>params[:search_by])
      end
  	else
  		@gigs = Gig.all
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
