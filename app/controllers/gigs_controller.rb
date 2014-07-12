class GigsController < ApplicationController
  before_action :set_gig, only: [:show, :edit, :update, :destroy, :purchase, :confirm_order]
  before_filter :authenticate_user!  , :except=> [:index, :show, :tag_cloud]
  # GET /gigs
  # GET /gigs.json
  def index
   # @tags = Tag.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    @gigs = Gig.all
  end

  # GET /gigs/1
  # GET /gigs/1.json
  def show
    @user_gig_transaction = @gig.transactions.where(user_id: current_user.id) if user_signed_in?
    @slide= @gig.videos + @gig.images
    @avg_rate = @gig.average_rating
    if user_signed_in?
      @rating = Rating.where(gig_id: @gig.id, user_id: current_user.id).first 

      @rating = Rating.create(gig_id: @gig.id, user_id: current_user.id, score: 0)  
    end
  end

  def tag_cloud
    @tags = Gig.tag_counts_on(:tags)
  end

  # GET /gigs/new
  def new
    @gig = Gig.new
    respond_to do |format|
    format.js
    format.html 
    end
  end

  # GET /gigs/1/edit
  def edit
  end

  # POST /gigs
  # POST /gigs.json
  def create
    @gig = current_user.gigs.new(gig_params)

    respond_to do |format|
      if (!params[:images].nil? || !params[:videos].first[1].blank?) && @gig.save
        if params[:images]
          params[:images].each { |image|
            @gig.images.create(image: image)
          }
        end
        if (1..params[:videos].count).each do |video|
            @gig.videos.create(video_url: params[:videos][video.to_s]) if !params[:videos][video.to_s].blank?
          end
        end
        format.html { redirect_to @gig, notice: 'Gig was successfully created.' }
        format.json { render :show, status: :created, location: @gig }
      else
        @gig.errors["gig"] = "must either have a Image or Video attached" if @gig.errors.full_messages.blank?
        format.html { render :new }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gigs/1
  # PATCH/PUT /gigs/1.json
  def update
    respond_to do |format|
      if @gig.update(gig_params)
        format.html { redirect_to @gig, notice: 'Gig was successfully updated.' }
        format.json { render :show, status: :ok, location: @gig }
      else
        format.html { render :edit }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gigs/1
  # DELETE /gigs/1.json
  def destroy
    @gig.destroy
    respond_to do |format|
      format.html { redirect_to gigs_url, notice: 'Gig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def purchase
    $total_amount = (params[:quantity].to_i)*5

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

    if Rails.env == "development"
      response = EXPRESS_GATEWAY.setup_purchase($total_amount*100,
        return_url: 'http://localhost:3000'+confirm_order_gig_path ,
        cancel_return_url: 'http://localhost:3000',
        currency: "USD",
        items: extra_array
      )
    else
      response = EXPRESS_GATEWAY.setup_purchase($total_amount*100,
        return_url: 'http://gig-mktplace.herokuapp.com'+confirm_order_gig_path ,
        cancel_return_url: 'http://gig-mktplace.herokuapp.com',
        currency: "USD",
        items: extra_array
      )
      
    end
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

    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def confirm_order

    @transactions = current_user.transactions.where(@gig.id)
    response = EXPRESS_GATEWAY.purchase($total_amount*100, {:token => params[:token],:payer_id => params[:PayerID]})

    if response.success?
      @transactions.each do |transaction|
        transaction.update_attributes(paypal_token: params[:token], paypal_payer_id: params[:PayerID], status: "Success")
      end
    end

    @msg_sender = User.find(@gig.user_id)

    @conv = Conversation.find_conversation(current_user, @msg_sender)
    @conversation = @conv.nil? ? Conversation.create(user_id: current_user.id,sender_id: @msg_sender.id) : @conv
    @message = @conversation.messages.create(content: @gig.instructions_for_buyer, user_id: @msg_sender.id)
    redirect_to @gig, notice: 'Payment Successfully Done'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gig
      @gig = Gig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gig_params
      params.require(:gig).permit(:tag_list,:title, :image_id, :videos, :description, :instructions_for_buyer, :tags, :express_boolean).merge(category_id: params[:category_id])
    end
end
