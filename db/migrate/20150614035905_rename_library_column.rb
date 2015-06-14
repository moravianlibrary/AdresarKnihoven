class RenameLibraryColumn < ActiveRecord::Migration
  def change
    rename_column :libraries, :type, :context
  end
end
