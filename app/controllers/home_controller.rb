class HomeController < ApplicationController

  def index 
  	if params[:search_by]
      if params[:search_by].to_i.zero?
        @gigs = []
        @category_ids = Category.where(title: params[:search_by]).collect(&:id)
        @category_ids.each do |category_id| 
          @gigs += Gig.where(:category_id=>category_id.to_i) if !Gig.where(:category_id=>category_id.to_i).blank?
        end
      else
  		  @gigs=Gig.where(:category_id=>params[:search_by].to_i)
      end
  	else
  		@gigs = Gig.all
  	end

    @videos=[] 
    @gigs.each do |gig|
      @videos << gig.videos.first if !gig.videos.first.nil?
    end

  end


end
