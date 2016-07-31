json.array!(@libraries) do |library|
  json.extract! library, :sigla, :longitude, :latitude
  json.name library.marker_name(@lang)
  json.address library.marker_address
end
