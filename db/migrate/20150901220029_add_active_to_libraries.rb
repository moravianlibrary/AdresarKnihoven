class AddActiveToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :active, :boolean
  end
end
