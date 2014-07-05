json.array!(@extragigs) do |extragig|
  json.extract! extragig, :id, :title, :amount, :express_boolean
  json.url extragig_url(extragig, format: :json)
end
