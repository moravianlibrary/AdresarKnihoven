json.array!(@libraries) do |library|
  json.extract! library, :sigla, :name, :code, :city, :street, :zip, :longitude, :latitude, :description, :district, :town, :context, :active, :ico, :dic
  json.url library_url(library, format: :json)
end
