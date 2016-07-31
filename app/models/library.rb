class Library < ActiveRecord::Base
	has_many :phones, dependent: :destroy
	has_many :faxes, dependent: :destroy
	has_many :people, dependent: :destroy
	has_many :emails, dependent: :destroy
	has_many :websites, dependent: :destroy
	has_many :branches, dependent: :destroy
	has_one :opening_hour, dependent: :destroy
	has_and_belongs_to_many :services
	has_and_belongs_to_many :projects

	def self.search(search, page)
		order('name').where('LOWER(name) LIKE ? OR LOWER(sigla) = ? OR LOWER(code) = ? OR LOWER(city) = ?', "%#{search}%", "#{search}", "#{search}", "#{search}").order(:name).paginate(page: page, per_page: 20)
	end

	def to_param
   	sigla
  end	


	def marker_name(lang = "cs")
		if lang == "en" && name_en
			format_name(name_en, bname_en, cname_en)
		else 
			format_name(name, bname, cname)
		end
	end


	def marker_address
		"#{street}, #{zip} #{city}"
	end


	private 
  	def format_name(a, b, c)
  		result = ""
  		result = a if a
  		result = "#{result}, #{b}" if b
  		result = "#{result} - #{c}" if c
  		result
  	end


end
