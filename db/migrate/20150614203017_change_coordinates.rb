class ChangeCoordinates < ActiveRecord::Migration
  def change
  	add_column :libraries, :longitude, :float
  	add_column :libraries, :latitude, :float
  	remove_column :libraries, :coordinates, :string
  end
end
