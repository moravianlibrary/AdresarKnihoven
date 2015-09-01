class RemoveUrlFromLibraries < ActiveRecord::Migration
  def change
    remove_column :libraries, :url, :string
  end
end
