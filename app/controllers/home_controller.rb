class HomeController < ApplicationController
  include HomeHelper

  def index
    @gigs = params[:search].present? ? Gig.where("title LIKE ?", "%#{params[:search]}%") : Gig.all
  end

  def search_by_category
    find_gig_and_banners
  end


  def search_by_subcategory
    find_gig_and_banners
  end


end
