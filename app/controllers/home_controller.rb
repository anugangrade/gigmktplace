class HomeController < ApplicationController
  include HomeHelper

  def index 
  	@gigs = Gig.all
    find_gig_and_banners
  end

  def search_by_category
    @category_ids = Category.where(category_url: params[:category_url]).collect(&:id)
    find_gig_and_banners
  end


  def search_by_subcategory
    @category_ids = Category.where(category_url: params[:category_url], subcategory_url: params[:subcategory_url]).collect(&:id)
    find_gig_and_banners
  end


end
