json.array!(@libraries) do |library|
  json.extract! library, :sigla, :name, :name_en, :bname, :bname_en, :cname, :cname_en, :code, :city, :street, :zip, :longitude, :latitude, :description, :region, :district, :context, :active, :ico, :dic, :mvs_description, :mvs_url
  json.url api_library_url(library, format: :json)
end
