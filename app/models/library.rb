class Library < ActiveRecord::Base
	has_many :phones, dependent: :destroy
	has_many :faxes, dependent: :destroy
	has_many :people, dependent: :destroy
	has_many :emails, dependent: :destroy
	has_many :websites, dependent: :destroy
	def self.search(search, page)
		order('name').where('LOWER(name) LIKE ? OR LOWER(sigla) = ? OR LOWER(code) = ?', "%#{search}%", "#{search}", "#{search}").paginate(page: page, per_page: 40)
	end
end
