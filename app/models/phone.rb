class Phone < ActiveRecord::Base
  belongs_to :library
  validates :library_id, :presence => true
  validates :phone, :presence => true  
end
