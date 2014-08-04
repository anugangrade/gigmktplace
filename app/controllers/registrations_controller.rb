class RegistrationsController < Devise::RegistrationsController
def new
    super
  end

  def create
    super

    @username = params['user']['name'].downcase.split(" ")[0]
    @users_username = User.where("username LIKE ?",  "%#{@username}%")  
    if !@users_username.blank?
      @number = @users_username.collect(&:username).last.scan( /\d+$/ ).first.to_i
      @username = @username+(@number+1).to_s
    end
    @user.update_attributes(username: @username, active: true)
  end

  def edit
  end

  def update
  	 account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    account_update_params.delete("current_password")
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end

  end

end