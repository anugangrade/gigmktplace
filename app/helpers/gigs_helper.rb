module GigsHelper
  include ActsAsTaggableOn::TagsHelper

  def show_helper
  	@user_gig_transaction = @gig.transactions.where(user_id: current_user.id) if user_signed_in?
    @slide= @gig.videos + @gig.images
    @avg_rate = @gig.average_rating
    @comm_avg_rate = @gig.communication_average_rate
    @service_avg_rate = @gig.service_average_rate
    @recommend_avg_rate = @gig.recommend_average_rate
    if user_signed_in?
      @rating = Rating.where(gig_id: @gig.id, user_id: current_user.id).first 
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

    extragigs_quatity_id = []
    if !params["extragig"].nil?
      params["extraquantity"].each do |extra|
        extra_inner_hash = []
        quantity =  extra.split("_")[0].to_i
        extra_id = extra.split("_")[2]
        extra_inner_hash[0] = extra_id
        extra_inner_hash[1] = quantity
        if params["extragig"].include? extra_id
          extragig = Extragig.find(extra_id)
          $total_amount += (quantity*(extragig.amount))
          inner_element = {name: "Gig Extras", description: "Purchase #{extragig.title}", quantity: quantity, amount: (extragig.amount)*100}
        end
        extra_array << inner_element
        extragigs_quatity_id << extra_inner_hash
      end
    end
    extra_array = extra_array.compact

    base_url = (Rails.env == "development") ? 'http://localhost:3000' : 'http://gig-mktplace.herokuapp.com'
    

    @response = EXPRESS_GATEWAY.setup_purchase($total_amount*100,
      return_url: base_url+confirm_order_gig_path ,
      cancel_return_url: base_url,
      currency: "USD",
      items: extra_array
    )
    random_string = Array.new(12){[*'0'..'9', *'A'..'Z'].sample}.join
    if @response.success?
      @transaction = current_user.transactions.new(gig_id: @gig.id, gig_quantity:params[:quantity], extragig_ids: params["extragig"], total_amount: $total_amount, extragigs_quatity_id: extragigs_quatity_id , status: "Pending", order_number: random_string )
      unless @transaction.save
        @transaction.order_number = Array.new(12){[*'0'..'9', *'A'..'Z'].sample}.join
        @transaction.save
      end
    end
  end


end