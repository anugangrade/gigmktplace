ActiveAdmin.register Gig do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :category_id, :user_id, :description, :instructions_for_buyer, :tags, :express_boolean, :sub_category_id, :url, :delivery_within
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
