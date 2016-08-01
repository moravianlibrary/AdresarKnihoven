json.limit @limit
json.offset @offset
json.all @count
json.libraries do
	json.array!(@libraries) do |library|
	  json.extract! library, :sigla, :name, :name_en, :bname, :bname_en, :cname, :cname_en, :code, :city, :street, :zip, :longitude, :latitude, :region, :district, :context, :active
	  json.distance library.distance
	  json.url api_v1_library_url(library, format: :json)
	end
end