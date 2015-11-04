class Fax < ActiveRecord::Base
  belongs_to :library
  validates :library_id, :presence => true
  validates :fax, :presence => true   

  default_scope  { order(:id => :asc) }
  
end
