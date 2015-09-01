json.array!(@libraries) do |library|
  json.extract! library, :id, :name, :code, :city, :street, :zip, :longitude, :latitude, :description, :sigla, :district, :town, :url, :context, :phone, :email
  json.url library_url(library, format: :json)
end
