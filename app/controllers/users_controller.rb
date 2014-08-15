class UsersController < ApplicationController
  before_action :set_user, only: [:finish_signup, :profile, :conversation]
  before_filter :authenticate_user!  , :except=> [:profile]

  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(user_params)
        # current_user.skip_reconfirmation!
        sign_in(current_user, :bypass => true)
        redirect_to root_path, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  def profile
    @country_sales = [['Country', 'Sales']]
    @gigs=@user.gigs

    User.where.not(id: @user.id).group_by(&:country).each do |country, users|
      @count = 0
      users.each do |user|
        @gigs.collect(&:id).each {|id| @count += user.transactions.where(gig_id: id, order_status: "complete").count }
      end
      @country_sales << [country, @count] if @count != 0
    end

    @country_sales = @country_sales.to_json
    

    # @gigs.each do |gig|
    #   gig.transactions.each_with_index do |transaction|
    #     country_sale << transaction.user.country

    #   end
    # end
  end

  def conversations
    @conversations = Conversation.where("user_id = ? OR sender_id = ?", current_user.id, current_user.id)
  end

  def conversation
    if @user != current_user
      @conversation = Conversation.find_conversation(@user, current_user)
      @messages = @conversation.messages if !@conversation.nil?
      @message = Message.new
    else
      redirect_to conversations_path
    end
  end

  def save_message
    @receiver = User.find(conversation_params[:user_id])
    @sender = User.find(conversation_params[:sender_id])
    
    @conv = Conversation.find_conversation(@receiver, @sender)
    @conversation = @conv.nil? ? Conversation.create(conversation_params) : @conv

    @message = @conversation.messages.create(message_params)
    if !params[:attachment].nil?
      attachment_params["file"].each do |attach|
        @message.attachments.create(:file=> attach)
      end
    end

    redirect_to conversation_path(@receiver)
  end

  def download_file
    @attachment = Attachment.find(params[:id])
    data = open(@attachment.file.url)
    send_file data.read, :type=>data.content_type, :x_sendfile=>true
  end

  def collection
    @collections = current_user.collections
    @gigs = []
    if params["id"]
      current_user.bookmarks.where(collection_id: params["id"]).each {|b| @gigs << b.gig }
    else
      current_user.bookmarks.each {|b| @gigs << b.gig }
    end

    if params[:collection].present?
      current_user.collections.create(collection_params) if current_user.collections.where(name: collection_params["name"]).blank?
    end
  end

  def orders
    @my_orders = current_user.transactions
    current_user.gigs.each do |gig|
      @my_orders += gig.transactions
    end
  end

  def order_messages
    @transaction = Transaction.where(order_number: params[:order_number])[0]
    @gig = Gig.find(@transaction.gig_id)
    @seller = User.find(@transaction.order_conversation.sender_id)
    @buyer = User.find(@transaction.order_conversation.user_id)
    @messages = @transaction.order_conversation.order_messages

    @order_message = OrderMessage.new
    attachments = @order_message.attachments.build
  end

  def save_order_message
    @order_message = OrderMessage.create(order_message_params)
    @transaction = Transaction.find(params[:transaction_id])
    if !params[:attachment].nil?
      attachment_params["file"].each do |attach|
        @order_message.attachments.create(:file=> attach)
      end
    end
    redirect_to order_messages_path(username: current_user.username, order_number: @transaction.order_number)
  end

  def order_complete
    @transaction = Transaction.find(params[:id])
    @transaction.update_attributes(order_status: "complete")
    redirect_to order_messages_path(username: current_user.username, order_number: @transaction.order_number)
  end

  def save_review
    @transaction = Transaction.find(params[:transaction_id])
    @review = current_user.reviews.create(review_params)
    redirect_to order_messages_path(username: current_user.username, order_number: @transaction.order_number), notice: 'Thanks for giving your review.'
  end


  private
    def set_user
      @user = params[:username].present? ? User.find_by_username(params[:username]) : User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

    def conversation_params
      params.require(:conversation).permit(:user_id,:sender_id)
    end

    def message_params
      params.require(:message).permit(:content,:user_id)
    end

    def attachment_params
      params.require(:attachment).permit(:file => [])
    end

    def collection_params
      params.require(:collection).permit(:name)
    end

    def order_message_params
      params.require(:order_message).permit(:order_conversation_id, :content, :user_id)
    end

    def review_params
      params.require(:review).permit(:gig_id, :content, :like_it)
    end
end