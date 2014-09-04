json.array!(@posts) do |post|
  json.extract! post, :id, :title, :description, :image_url, :post_type
  json.url post_url(post, format: :json)
end
