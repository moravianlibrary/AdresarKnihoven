class AddLogitudeAndLatitudeToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :longitude, :float
    add_column :branches, :latitude, :float
  end
end
