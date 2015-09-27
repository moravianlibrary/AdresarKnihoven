json.array!(@libraries) do |library|
  json.extract! library, :sigla, :name, :name_en, :code, :city, :street, :zip, :longitude, :latitude, :description, :district, :town, :context, :active, :ico, :dic, :mvs_description, :mvs_url
  json.url library_url(library, format: :json)
end
