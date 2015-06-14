class Library < ActiveRecord::Base


def self.search(search, page)
	order('name').where('UPPER(name) LIKE ? OR sigla = ? OR code = ?', "%#{search}%", "#{search}", "#{search}").paginate(page: page, per_page: 40)
end

end
