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
    @conversation = Conversation.find_conversation(@user, current_user)
    @messages = @conversation.messages if !@conversation.nil?
    @message = Message.new
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


  private
    def set_user
      @user = User.find(params[:id])
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
end