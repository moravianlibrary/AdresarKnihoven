json.array!(@libraries) do |library|
  json.extract! library, :name, :name_en
end
