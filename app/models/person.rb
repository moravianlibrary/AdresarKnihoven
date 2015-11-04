class Person < ActiveRecord::Base
  belongs_to :library
  validates :library_id, :presence => true

  default_scope  { order(:id => :asc) }
  
end
