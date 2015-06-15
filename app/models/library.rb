class Library < ActiveRecord::Base

	def self.search(search, page)
		order('name').where('LOWER(name) LIKE ? OR LOWER(sigla) = ? OR LOWER(code) = ?', "%#{search}%", "#{search}", "#{search}").paginate(page: page, per_page: 40)
	end

end
