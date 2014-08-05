class GigsController < ApplicationController
  include GigsHelper
  before_action :set_gig, only: [:show, :edit, :update, :destroy, :purchase, :confirm_order, :bookmark]
  before_filter :authenticate_user!  , :except=> [:index, :show, :tag_cloud]

  # GET /gigs
  # GET /gigs.json
  def index
    @gigs = Gig.all
  end

  # GET /gigs/1
  # GET /gigs/1.json
  def show
    show_helper
  end

  def tag_cloud
    @tags = Gig.tag_counts_on(:tags)
  end

  # GET /gigs/new
  def new
    @gig = Gig.new
  end

  # GET /gigs/1/edit
  def edit
  end

  # POST /gigs
  # POST /gigs.json
  def create
    create_helper
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
      format.html { redirect_to root_url, notice: 'Gig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def purchase
    $total_amount = (params[:quantity].to_i)*5
    purchase_helper
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

  def bookmark
    @gig_id = params["id"]
    @bookmark = current_user.bookmarks.where(gig_id: @gig_id)[0]
    if @bookmark.nil?
      @bookmark = current_user.bookmarks.create(gig_id: @gig_id)
    else
      @bookmark.destroy
      @bookmark = nil
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gig
      @gig = params[:id].present? ? Gig.find(params[:id]) : Gig.find_by_url(params[:url])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gig_params
      params.require(:gig).permit(:tag_list,:title, :image_id, :videos, :description, :instructions_for_buyer, :tags, :express_boolean, :category_id, :sub_category_id)
    end
end
