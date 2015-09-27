class AddNameEnToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :name_en, :string
  end
end
