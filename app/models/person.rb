class Person < ActiveRecord::Base
  belongs_to :library

  default_scope  { order(:id => :asc) }
  
end
