class AddMvsToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :mvs_description, :string
    add_column :libraries, :mvs_url, :string
  end
end
