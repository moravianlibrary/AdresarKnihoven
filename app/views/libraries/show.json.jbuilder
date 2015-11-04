json.extract! @library, :sigla, :name, :name_en, :code, :city, :street, :zip, :longitude, :latitude, :description, :region, :district, :context, :active, :ico, :dic, :mvs_description, :mvs_url, :created_at, :updated_at
json.people {
	json.array!(@library.people) do |person|
	  json.extract! person, :first_name, :last_name, :email, :phone, :degree1, :degree2, :role
	end
}
json.websites {
	json.array!(@library.websites) do |website|
	  json.extract! website, :url, :note
	end
}
json.emails {
	json.array!(@library.emails) do |email|
	  json.extract! email, :email, :note
	end
}
json.phones {
	json.array!(@library.phones) do |phone|
	  json.extract! phone, :phone
	end	
}
json.faxes {
	json.array!(@library.faxes) do |fax|
	  json.extract! fax, :fax
	end	
}
json.branches {
	json.array!(@library.branches) do |branch|
	  json.extract! branch, :name, :address, :longitude, :latitude
	end
}