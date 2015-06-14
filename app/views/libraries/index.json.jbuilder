json.array!(@libraries) do |library|
  json.extract! library, :id, :name, :code, :city, :street, :zip, :longitude, :latitude, :description, :email, :sigla, :district, :town, :url, :context, :phone
  json.url library_url(library, format: :json)
end
