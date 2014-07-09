class User < ActiveRecord::Base

  has_many :gigs, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :transactions

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/


  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, #:confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable #:token_authenticatable
    

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates_presence_of :name
  validates_uniqueness_of :username, :allow_blank => true
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny=>"50x50>" }, :default_url => "missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def average_rating
    ratings.sum(:score) / ratings.size
  end

  
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email
      avatar_url = process_uri(auth.info.image) 

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20],
          oauth_token: auth.credentials.token,
          avatar: avatar_url,
          location: auth.info.location
        )
        # user.skip_confirmation!
        @username = user.name.downcase.split(" ")[0]
        @users_username = User.where("username LIKE ?",  "%#{@username}%")  
        if !@users_username.blank?
          @number = @users_username.collect(&:username).last.scan( /\d+$/ ).first.to_i
          user.username = @username+(@number+1).to_s
        else
          user.username = @username
        end
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end


  private

    def self.process_uri(uri)
      require 'open-uri'
      require 'open_uri_redirections'
      open(uri, :allow_redirections => :safe) do |r|
        r.base_uri.to_s
      end
    end



end
