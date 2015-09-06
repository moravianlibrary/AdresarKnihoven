json.extract! @library, :id, :name, :code, :city, :street, :zip, :longitude, :latitude, :description, :sigla, :district, :town, :context, :created_at, :updated_at
json.websites @library.websites
json.people @library.people
json.phones @library.phones
json.branches @library.branches
json.faxes @library.faxes
json.emails @library.emails