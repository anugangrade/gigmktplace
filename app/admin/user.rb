ActiveAdmin.register User do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :email, :password, :password_confirmation, :name, :oauth_token, :description, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :location, :username, :active, :country
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
