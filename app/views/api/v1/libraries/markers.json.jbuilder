json.array!(@libraries) do |library|
  json.extract! library, :sigla, :name, :name_en, :bname, :bname_en, :cname, :cname_en, :city, :street, :zip, :longitude, :latitude
end
