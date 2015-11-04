class RenameColumnTownInLibraryToDistrict < ActiveRecord::Migration
  def change
  	rename_column :libraries, :town, :district
  end
end
