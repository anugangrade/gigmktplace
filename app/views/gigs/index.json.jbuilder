json.array!(@gigs) do |gig|
  json.extract! gig, :id, :title, :category_id, :subcategory_id, :user_id, :image_id, :video_id, :description, :instructions_for_buyer, :tags, :express_boolean
  json.url gig_url(gig, format: :json)
end
