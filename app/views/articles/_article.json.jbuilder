json.extract! article, :id, :name, :price, :size, :category, :img, :color, :created_at, :updated_at
json.url article_url(article, format: :json)
