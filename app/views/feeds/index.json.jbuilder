json.array!(@feeds) do |feed|
  json.extract! feed, :id, :title, :published, :summary, :created_at, :is_read, :updated_at
  json.url feed_url(feed, format: :json)
end
