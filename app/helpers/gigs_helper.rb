module GigsHelper
  include ActsAsTaggableOn::TagsHelper

  def show_helper
  	@user_gig_transaction = @gig.transactions.where(user_id: current_user.id) if user_signed_in?
    @slide= @gig.videos + @gig.images
    @avg_rate = @gig.average_rating
    if user_signed_in?
      @rating = Rating.where(gig_id: @gig.id, user_id: current_user.id).first 
      # @rating = Rating.create(gig_id: @gig.id, user_id: current_user.id, score: 0)  
    end
  end

  def create_helper
    @gig = current_user.gigs.new(gig_params)

    respond_to do |format|
      if (!params[:images].nil? || !params[:videos][0].blank?) && @gig.valid?
      	@gig.save
        @gig.update_attributes(url: @gig.title.parameterize+"-"+@gig.id.to_s)
        params[:images].each { |image| @gig.images.create(image: image) } if params[:images]
        params[:videos].each { |video| @gig.videos.create(video_url: video) } if !params[:videos][0].blank?
        
        format.html { redirect_to @gig, notice: 'Gig was successfully created.' }
        format.json { render :show, status: :created, location: @gig }
      else
        @gig.errors["gig"] = "must either have a Image or Video attached" if @gig.errors.full_messages.blank?
        format.html { render :new }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  def purchase_helper
  	extra_array = [{name: "Order Gig", description: "Purchase #{@gig.title}", quantity: params[:quantity], amount: 500}]

    if !params["extragig"].nil?
      params["extraquantity"].each do |extra|
        quantity =  extra.split("_")[0].to_i
        extra_id = extra.split("_")[2]
        if params["extragig"].include? extra_id
          extragig = Extragig.find(extra_id)
          $total_amount += (quantity*(extragig.amount))
          inner_element = {name: "Gig Extras", description: "Purchase #{extragig.title}", quantity: quantity, amount: (extragig.amount)*100}
        end
        extra_array << inner_element
      end
    end
    extra_array = extra_array.compact

    base_url = (Rails.env == "development") ? 'http://localhost:3000' : 'http://gig-mktplace.herokuapp.com'
    response = EXPRESS_GATEWAY.setup_purchase($total_amount*100,
      return_url: base_url+confirm_order_gig_path ,
      cancel_return_url: base_url,
      currency: "USD",
      items: extra_array
    )
    
    if response.success?
      current_user.transactions.create(gig_id: @gig.id, quantity:params[:quantity], status: "Pending")
      if !params["extragig"].nil?
        params["extraquantity"].each do |extra|
          extra_id = extra.split("_")[0]
          quantity =  extra.split("_")[1].to_i
          if params["extragig"].include? extra_id
            extragig = Extragig.find(extra_id)
            current_user.transactions.create(gig_id: extragig.gig.id, extragig_id: extragig.id, quantity:quantity, status: "Pending")
          end
        end
      end
    end
  end
end
