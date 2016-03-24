json.array!(@services) do |service|
  json.extract! service, :code, :name
end
