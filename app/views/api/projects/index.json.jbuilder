json.array!(@projects) do |project|
  json.extract! project, :code, :name, :description, :url
end
