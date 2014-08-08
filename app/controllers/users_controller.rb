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
    @gigs=@user.gigs
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

  def message
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
  end

  def order_messages
    @transaction = Transaction.where(order_number: params[:order_number])[0]
    @gig = Gig.find(@transaction.gig_id)
    @seller = User.find(@transaction.order_conversation.sender_id)
    @buyer = User.find(@transaction.order_conversation.user_id)
    @messages = @transaction.order_conversation.order_messages
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
end