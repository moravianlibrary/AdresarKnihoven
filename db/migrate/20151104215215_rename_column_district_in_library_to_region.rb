class RenameColumnDistrictInLibraryToRegion < ActiveRecord::Migration
  def change
  	rename_column :libraries, :district, :region
  end
end
