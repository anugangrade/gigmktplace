ActiveAdmin.register Transaction do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :user_id, :gig_id, :gig_quantity, :paypal_token, :paypal_payer_id, :status, :extragig_ids, :total_amount, :extragigs_quatity_id, :order_number, :order_status
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
