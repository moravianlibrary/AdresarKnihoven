json.array!(@events) do |event|
	json.extract! event, :id, :title, :description, :url, :date, :place
  json.url event_url(event, format: :json)
end
