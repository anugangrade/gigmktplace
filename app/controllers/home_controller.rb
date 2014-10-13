class HomeController < ApplicationController
  include HomeHelper

  def index
    # @gigs = params[:search].present? ? Gig.where("title LIKE ?", "%#{params[:search]}%") : Gig.where(featured: true)
    @gigs = Gig.paginate(page: params[:page], per_page: 8)
  end

  def search_by_category
    find_gig_and_banners
  end


  def search_by_subcategory
    find_gig_and_banners
  end


end
